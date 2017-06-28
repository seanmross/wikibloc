class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      wikis = []
      if user.admin?
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.collaborators?(user)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # standard users
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array
    end
  end
end
