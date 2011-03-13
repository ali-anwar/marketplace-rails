class Ad < ActiveRecord::Base
  before_create :create_user

  belongs_to :category
  belongs_to :city
  belongs_to :user

  has_many :details

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

  validates_presence_of     :region, :message => "should be selected"

  validates_numericality_of :price

  validates_presence_of     :password, :if => :has_new_user?
  validates_confirmation_of :password, :if => :has_new_user?, :message => "should match confirmation"

  def initialize(options = {})
    options[:t] ||= {}
    super(options)
  end

  def has_new_user?
    self.user_id.blank?
  end

  private

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
