# frozen_string_literal: true

Then(/^user should see "([^"]*)"$/) do |content_text|
  expect(page).to have_content(content_text)
end

Then(/^user should see "([^"]*)" element$/) do |css_sel|
  expect(page).to have_selector(css_sel)
end

Then(/^user should see "([^"]*)" element with text "([^"]*)"$/) do |css_sel, text|
  expect(find(css_sel)).to have_content(text)
end

Then(/^user should see "([^"]*)" toast with text "([^"]*)"$/) do |type, text|
  step %(user should see ".toast .alert.alert-#{type}" element with text "#{text}")
end

When(/^user visits "([^"]*)"$/) do |path|
  visit path
end

When(/^user clicks "([^"]*)" link$/) do |link_text|
  click_on link_text
end

When(/^user clicks "([^"]*)" button$/) do |button_text|
  click_on button_text
end

When(/^user inputs "([^"]*)" into "([^"]*)" field$/) do |value, field_id|
  fill_in(field_id, with: value)
end
