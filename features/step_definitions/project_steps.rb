Given /^the following projects$/ do |table|
  table.hashes.each do |hash|
    country = Place.find_by_name(hash["country"]) || Factory(:country, :name => hash["country"])
    partner = Partner.find_by_name(hash["partner"]) || Factory(:partner, :name => 'Tag Solutions', :partner_status_id => PartnerStatus.active.id)
    project = Factory(:project, :name => hash["name"], :total_cost => hash["total_cost"], :project_status_id => ProjectStatus.public_ids.first, :partner => partner, :country => country)
    project.sectors << Sector.find_or_create_by_name(hash["sector"])
    assert Project.current.include? project
  end
end

Given /^the project indexes are processed$/ do
  ThinkingSphinx::Test.index 'project_core', 'project_delta'
  sleep(0.25)
end