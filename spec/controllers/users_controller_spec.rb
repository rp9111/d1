require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

# require 'admin/areas_controller'

RSpec.describe UsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Area. As you add validations to Area, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { user_name: 'olivia', email: 'olivia@wilde.com', password: 'password' }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AreasController. Be sure to keep this updated too.
  let(:valid_session) {
    @u ||= FactoryGirl.create :user
    cookies['auth_token'] = @u.token
    { auth_token: @u.token }
   }

  describe "POST #create" do
    it 'creates a new user' do
      expect {
        post :create, params: valid_attributes
      }.to change(User, :count).by(1)
    end
    it 'requires a user_name' do
      attributes = valid_attributes
      attributes.delete :user_name
      expect {
        post :create, params: attributes
      }.to_not change(User, :count)
    end
  end
    # it 'requires an email' do
    #   attributes = valid_attributes
    #   attributes.delete :email
    #   expect {
    #     post :create, params: attributes, session: valid_session
    #   }.to_not change(User, :count)
    # end
  describe 'PATCH #update' do
    it 'rejects invalid updates' do
      valid_session
      patch :update, params: { user: { id: @u.to_param, email: 'invalid.email.com' }}, session: valid_session
      expect(response).to render_template('edit')
    end
  end
  describe 'DELETE #destroy' do
    it 'can be deleted' do
      valid_session
      expect {
        delete :destroy, session: valid_session
      }.to change(User, :count).by(-1)
    end
  end

end
