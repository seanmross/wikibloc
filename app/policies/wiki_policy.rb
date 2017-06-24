class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'standard'
        scope.where(private: false)
      else
        scope.all
      end
    end
  end
end
