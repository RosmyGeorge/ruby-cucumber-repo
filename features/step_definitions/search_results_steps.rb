Given(/^I am on google shopping search results page$/)  do
  visit SearchResultsPage
end

When(/^I filter for dress$/) do
  (on SearchResultsPage).google_search
end

Then(/^I should see the dresses displayed$/) do
  (on SearchResultsPage).google_dresses.should == true
end

When(/^I search by "([^"]*)" value and should see the results sorted/) do |text|
  (on SearchResultsPage).sorting_google_dress(text)
end
