Before do
  @browser = Watir::Browser.new :firefox
end

After do |scenario|
  @browser.quit
end