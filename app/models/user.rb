class User < ActiveRecord::Base
  include RoleModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments

  scope :active, lambda { where(:active => true) }


  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  ROLES = [:admin, :brewer, :sales]
  roles ROLES

  def short_name
    "#{self.first_name.capitalize} #{self.last_name.first.capitalize}."
  end

  # Called by Devise to see if an user can currently be signed in
  def active_for_authentication?
    active? && super
  end

  # Called by Devise to get the proper error message when an user cannot be signed in
  def inactive_message
    !active? ? :deactivated : super
  end

end
