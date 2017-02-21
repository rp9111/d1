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

RSpec.describe Admin::UsersController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for :user
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for :user, user_name: nil, email: nil, first_name: nil, last_name: nil
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) {
    @admin ||= FactoryGirl.create :user, admin: true
    cookies['auth_token'] = @admin.token
    { auth_token: @admin.token }
  }

  describe "GET #index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:users)).to eq([user, @admin])
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, params: {:id => user.to_param}, session: valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    it "assigns a new user as @user" do
      get :new, params: {}, session: valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :edit, params: {:id => user.to_param}, session: valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        valid_session
        expect {
          post :create, params: {:user => valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, params: {:user => valid_attributes}, session: valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created user" do
        post :create, params: {:user => valid_attributes}, session: valid_session
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, params: {:user => invalid_attributes}, session: valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:user => invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        put :update, params: {:id => user.to_param, :user => new_attributes}, session: valid_session
        user.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, params: {:id => user.to_param, :user => valid_attributes}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        put :update, params: {:id => user.to_param, :user => valid_attributes}, session: valid_session
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        put :update, params: {:id => user.to_param, :user => invalid_attributes}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        put :update, params: {:id => user.to_param, :user => invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      valid_session
      expect {
        delete :destroy, params: {:id => user.to_param}, session: valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete :destroy, params: {:id => user.to_param}, session: valid_session
      expect(response).to redirect_to(admin_users_path)
    end
  end

end
