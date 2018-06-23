module ControllerMacros

  def login
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryBot.create(:user) # Using factory girl as an example
    end
  end

  def logout
    before(:each) do
      sign_out user
    end
  end
end