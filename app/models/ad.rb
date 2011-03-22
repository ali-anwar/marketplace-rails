class Ad < ActiveRecord::Base
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

    has price

    has "private = 1",              :as => :private,              :facet => true, :type => :boolean
    has "private = 0",              :as => :company,              :facet => true, :type => :boolean
    has "CRC32(categories.name)",   :as => :category_name,        :facet => true, :type => :integer
    has "CRC32(categories.parent)", :as => :category_parent_name, :facet => true, :type => :integer
    has "CRC32(cities.name)",       :as => :city_name,            :facet => true, :type => :integer
    has "CRC32(cities.region)",     :as => :city_region,          :facet => true, :type => :integer

    has "CRC32(details.status)",           :as => :detail_status,                    :type => :integer
    has "CRC32(details.vehicle_category)", :as => :detail_vehicle_category,          :type => :integer
    has detail.number_of_rooms,            :as => :detail_number_of_rooms,           :type => :integer
    has detail.size,                       :as => :detail_size,                      :type => :integer
    has detail.vehicle_registration_year,  :as => :detail_vehicle_registration_year, :type => :integer
    has detail.vehicle_mileage,            :as => :detail_vehicle_mileage,           :type => :integer

    join category, city, details

    where "approved=1"
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
    [day, date, time].compact.join(' ')
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
