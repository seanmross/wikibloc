class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy
  has_many :wikis, through: :collaborations

  after_initialize { self.role ||= :standard}
  enum role: [:standard, :premium, :admin]

  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def set_wikis_public
    self.wikis.each { |wiki| wiki.update(private: false)}
  end

end
