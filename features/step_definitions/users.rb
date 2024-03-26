When(/^user registers as name "([^"]*)", email "([^"]*)", password "([^"]*)" and password confirmation "([^"]*)"$/) do |name, email, password, pw_conf|
  step %(user visits "/users/sign_up")
  step %(user inputs "#{name}" into "user_name" field)
  step %(user inputs "#{email}" into "user_email" field)
  step %(user inputs "#{password}" into "user_password" field)
  step %(user inputs "#{pw_conf}" into "user_password_confirmation" field)
  step %(user clicks "Sign Up" button)
end

When(/^user registers as name "([^"]*)", email "([^"]*)" and password "([^"]*)"$/) do |name, email, password|
  step %(user registers as name "#{name}", email "#{email}", password "#{password}" and password confirmation "#{password}")
end

When(/^user logs in with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  step %(user visits "/users/sign_in")
  step %(user inputs "#{email}" into "user_email" field)
  step %(user inputs "#{password}" into "user_password" field)
  step %(user clicks "Log In" button)
end

When(/^user logs out$/) do
  step %(user clicks "main-menu" button)
  step %(user clicks "logout" button)
end
