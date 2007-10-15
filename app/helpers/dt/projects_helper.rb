module Dt::ProjectsHelper
  def project_nav
    render 'dt/projects/project_nav'
  end

  def mdg_goals
    render 'dt/shared/mdg_goals'
  end
  
  def project_actions
    render 'dt/projects/project_actions'
  end

  def project_quickfacts
    render 'dt/projects/project_quickfacts'
  end

  def current_member(group, user = current_user)
    @current_member ||= group.memberships.find_by_user_id(user) if user
  end
end
