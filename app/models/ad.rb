class Ad < ActiveRecord::Base
  PER_PAGE    = 10
  MAX_MATCHES = 1000
  MAX_PAGES   = MAX_MATCHES / PER_PAGE
  MAX_INT     = 10000000
  MIN_INT     = -MAX_INT

  before_create :create_user
  after_save :store_details

  belongs_to :category
  belongs_to :city
  belongs_to :user

  has_one  :detail
  has_many :uploads,
           :attributes => true,
           :discard_if => proc { |upload| upload.photo_file_size.nil? }

  attr_protected :approved
  attr_accessor :region, :password, :t

  validates_presence_of     :name
  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  validates_presence_of     :phone
  validates_presence_of     :title
  validates_presence_of     :description

  validates_presence_of     :category_id, :message => "should be selected"
  validates_associated      :category

  validates_presence_of     :city_id, :message => "should be selected"
  validates_associated      :category

  validates_presence_of     :region, :message => "should be selected", :unless => :has_city?

  validates_numericality_of :price

  validates_presence_of     :password, :if => :has_new_user?
  validates_confirmation_of :password, :if => :has_new_user?, :message => "should match confirmation"

  define_index do
    indexes title
    indexes description

    has "CONVERT(price*100, UNSIGNED INTEGER)", :as => :price, :type => :integer

    has category.name,                     :as => :category_text,                                       :facet => true
    has category.parent,                   :as => :category_parent_text,                                :facet => true
    has city.name,                         :as => :city_text,                                           :facet => true
    has city.region,                       :as => :region_text,                                         :facet => true
    has "private = 1",                     :as => :private,                          :type => :boolean, :facet => true
    has "private = 0",                     :as => :company,                          :type => :boolean, :facet => true
    has "CRC32(categories.name)",          :as => :category_name,                    :type => :integer
    has "CRC32(categories.parent)",        :as => :category_parent_name,             :type => :integer
    has "CRC32(cities.name)",              :as => :city_name,                        :type => :integer
    has "CRC32(cities.region)",            :as => :city_region,                      :type => :integer
    has "CRC32(details.status)",           :as => :detail_status,                    :type => :integer
    has "CRC32(details.vehicle_category)", :as => :detail_vehicle_category,          :type => :integer
    has detail.number_of_rooms,            :as => :detail_number_of_rooms,           :type => :integer
    has detail.size,                       :as => :detail_size,                      :type => :integer
    has detail.vehicle_registration_year,  :as => :detail_vehicle_registration_year, :type => :integer
    has detail.vehicle_mileage,            :as => :detail_vehicle_mileage,           :type => :integer

    join category, city, details

    #where "approved=1"
  end

  def self.max_int
    MAX_INT
  end

  def self.min_int
    MIN_INT
  end

  def self.perform_search(options)
    o = default_search_options.merge(make_options(options))
    s = search options[:keyword], o
    s.to_a # Hack to actually perform query
    f = s.facets

    city_name = o[:with].delete(:city_name)
    c = s.empty? && (Hash.new {|k,v| k[v] = Hash.new}) || facets(o)

    o[:with][:city_name] = city_name if city_name
    o[:with].delete(:private)
    o[:with].delete(:company)

    a = facets(o)

    [s, f, a, c]
  end

  def self.make_range(l, u)
    return nil if l.blank? && u.blank?

    lower = l.blank? && min_int || l.to_i
    upper = u.blank? && max_int || u.to_i

    Range.new lower, upper
  end

  def self.make_options(options)
    search_options            = {:with => {}, :with_all => {}}
    search_options[:page]     = options[:page] || 1
    search_options[:per_page] = options[:per_page] || PER_PAGE
    search_options[:order]    = options[:order].blank? && "@id DESC" || "price ASC"

    [:private, :company].each do |v|
      search_options[:with][v] = true if options[v]
    end

    [:category_name, :category_parent_name, :city_name, :city_region, :detail_status, :detail_vehicle_category].each do |v|
      search_options[:with][v] = options[v] unless options[v].blank?
    end

    [[:min_rooms,       :max_rooms,       :detail_number_of_rooms],
     [:min_living_size, :max_living_size, :detail_size],
     [:reg_year_from,   :reg_year_to,     :detail_vehicle_registration_year],
     [:mileage_from,    :mileage_to,      :detail_vehicle_mileage],
    ].each do |(min, max, a)|
      range = make_range(options[min], options[max])
      search_options[:with][a] = range if range
    end

    search_options[:with][:detail_status] = options[:status] unless options[:status].blank?

    search_options
  end

  def self.default_search_options
    {:include       => [:city, :user, :category, :detail, :uploads],
     :per_page      => PER_PAGE,
     :page          => 1,
    }
  end

  def initialize(options = {})
    options[:t] ||= {}
    super(options)
  end

  def has_new_user?
    self.user_id.blank?
  end

  def has_city?
    !self.city_id.nil?
  end

  def logo
    photo = self.uploads.first.try(:photo)
    return 'no-logo.png' unless photo
    photo.url(:thumb)
  end

  def timestamp
    day  = {Date.today => "Today", Date.yesterday => "Yesterday"}[self.created_at.to_date] || self.created_at.strftime('%A')
    date = self.created_at.strftime("%m/%d/%Y") if self.created_at <= 1.week.ago
    time = self.created_at.strftime('%H:%M')
    [day, date, time].compact.join('<br/>')
  end

  private

  def store_details
    self.create_detail self.t unless self.t.blank?
  end

  def create_user
    return unless self.has_new_user?

    u   = User.find_by_email(self.email.downcase)
    u ||= User.create(:name => self.name, :email => self.email, :password => self.password, :password_confirmation => self.password)

    unless u.authenticated?(self.password)
      if u.errors.empty?
        self.errors.add_to_base "Invalid password for the specified email"
      else
        self.errors.add_to_base u.errors.full_messages.to_sentence
      end
      return false
    end

    self.user = u
  end
end
