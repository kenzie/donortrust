Given /^there is a project "([^"]*)" with total cost of \$(\d+)$/ do |project_name, total_cost|
  partner = Factory(:partner)
  
  project = Factory(:project, :name => project_name, :total_cost => total_cost, :project_status_id => 2, :partner => partner)
end

Given /^the project indexes are processed$/ do
  ThinkingSphinx::Test.index 'projects_core', 'projects_delta'
  sleep(0.25)
end