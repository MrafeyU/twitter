class PostPolicy < ApplicationPolicy
 def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user_is_author?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_author?
  end

  private

  def user_is_author?
    user.present? && record.user == user
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end


# # Assume your User model has a role column, e.g., "admin" or "user".
# class PostPolicy < ApplicationPolicy
#   def show?
#     true
#   end

#   def create?
#     user.present? # any logged-in user can create
#   end

#   def update?
#     admin_or_author?
#   end

#   def edit?
#     update?
#   end

#   def destroy?
#     admin_or_author?
#   end

#   private

#   def admin_or_author?
#     user.present? && (user.role == "admin" || record.user == user)
#   end

#   class Scope < ApplicationPolicy::Scope
#     def resolve
#       if user.role == "admin"
#         scope.all
#       else
#         scope.where(user: user)
#       end
#     end
#   end
# end