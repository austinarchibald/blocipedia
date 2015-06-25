class User < ActiveRecord::Base
  has_many :wikis

  after_initialize :default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def default_role
    self.role ||= 'free'
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def free?
    role == 'free'
  end
end
