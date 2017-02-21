def sign_in_as!(user)
  visit signin_path
  fill_in 'auth_key', with: user.email
  fill_in 'password', with: user.password
  submit_form
end

def signed_in_user
  user = FactoryGirl.create :user
  visit signin_path
  fill_in 'auth_key', with: user.email
  fill_in 'password', with: user.password
  submit_form
  user
end

def signed_in_admin
  admin = FactoryGirl.create :user, admin: true
  sign_in_as!(admin)
end