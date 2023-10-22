class ProjectPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  def index?
    true
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && owner?
  end

  def edit?
    project_membership.present?
  end

  def show?
    true
  end

  def update?
    user.present? && project_membership.present?
  end

  private

  def project_membership
    @project_membership ||= ProjectMembership.find_by(project: record.project, user: user)
  end

  def owner?
    project_membership&.owner?
  end
end