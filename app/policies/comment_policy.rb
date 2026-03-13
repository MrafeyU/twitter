class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end
  
  def destroy?
    user.present? &&  record.user == user
    
    # for admin
    # user.present? && (user.admin? || record.user == user)
   
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
