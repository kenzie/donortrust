require File.dirname(__FILE__) + '/../../test_helper'
require 'dt/search_controller'

# Re-raise errors caught by the controller.
class Dt::SearchController; def rescue_action(e) raise e end; end

context "Dt::Search     inheritance" do
  specify "should inherit from DtApplicationController" do
    @controller = Dt::SearchController.new
    @controller.kind_of?(DtApplicationController).should == true
  end
end

context "Dt::Search #route_for" do
  use_controller Dt::SearchController

  setup do
    @rs = ActionController::Routing::Routes
  end

  specify "should map { :controller => 'dt/search', :action => 'show' } to /dt/search" do
    route_for(:controller => "dt/search", :action => "show").should == "/dt/search"
  end
  private 
  def route_for(options)
    @rs.generate options
  end
end

context "Dt::Search handling GET /dt/search" do
  use_controller Dt::SearchController
  include DtAuthenticatedTestHelper
  fixtures :projects, :partners, :places
  
  specify "should use show template" do
    get :show
    template.should.be 'dt/search/show'
  end

  specify "should assign projects" do
    get :show
    assigns(:projects).should.not.be.nil
  end

  specify "if country_id is passed, projects should contain projects that have the country as their project.nation" do
    @country_id = 2
    get :show, :country_id => @country_id
    assigns(:projects).each do |project|
      project.nation.id.should.equal @country_id
    end
  end
end