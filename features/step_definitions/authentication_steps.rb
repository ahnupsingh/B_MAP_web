Given /^a user visits the login page$/ do
  visit login_path
end

When /^they submit invalid login information$/ do
  click_button "Log in"
end

Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword")
end

When /^the user submits valid signin information$/ do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button 'Log in'
end

Then /^they should see their profile page$/ do
  expect(page).to have_title(@user.name)
end

Then /^they should see a signout link$/ do
  expect(page).to have_link('Log out', link: logout_path)
end
