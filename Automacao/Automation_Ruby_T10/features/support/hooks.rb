require_relative 'prints'

Before do |scenario|
    Capybara.current_session.driver.browser.manage.delete_all_cookies
    Capybara.page.driver.browser.manage.window.maximize
end

After do |scenario|
    time = Time.now
    date = time.strftime("%d-%m-%Y")
    hour = time.strftime("%k-%M-%S")
    scenarioFolder = scenario.name.gsub(/\s+/, '_').tr('/', '_')
    folder_p = "screenshots/#{date}"
    name = "#{hour}-#{scenarioFolder}"

    if scenario.failed?
        Prints.take_screenshot(name, "#{folder_p}/test_failed")
    else
        Prints.take_screenshot(name, "#{folder_p}/test_passed")
    end
end