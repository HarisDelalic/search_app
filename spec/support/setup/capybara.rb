# Use puma as default Capybara server (https://github.com/teamcapybara/capybara#setup)
Capybara.server = :puma, { Silent: true } # To clean up your test output

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_chrome
Capybara.default_max_wait_time = 2