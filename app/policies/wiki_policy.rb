class WikiPolicy < ApplicationPolicy

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.nil? || user.free?
        scope.where(:private => false)
      elsif user.premium? || user.admin?
        scope.all
      end
    end
  end
end