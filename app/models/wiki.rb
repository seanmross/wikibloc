class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  def private?
    private == true
  end

  def public?
    private == false
  end

  def collaborators?(user)
    Collaboration.where(wiki_id: self.id, user_id: user.id).take
  end

end
