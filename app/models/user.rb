class User < ActiveRecord::Base
  include RoleModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  ROLES = [:admin, :brewer, :sales]
  roles ROLES

end
