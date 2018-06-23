require 'rails_helper'

RSpec.describe SkusController, type: :controller do
	render_views
	login

	before :each do
	  @file = fixture_file_upload('files/mycsv.csv', 'text/csv')
	end
	
	it "should have a current_user" do
    	expect(subject.current_user).to_not eq(nil)
 	end



 	describe "GET #new" do
	    it "renders the new template" do
	      get :new
	      expect(response).to render_template("new")
	    end

	    it "responds successfully with an HTTP 200 status code" do
	      get :new
	      expect(response).to be_success
	      expect(response).to have_http_status(200)
	    end

	    it "create new sku object" do
	      expect(assigns(:sku)).to be_a_new(Sku)
	    end
	end

end
