require 'fileutils'

module Prints
  def self.take_screenshot(name_file, folder)
    file = "#{folder}/#{name_file}.png"
    FileUtils.mkdir_p(folder) unless File.exist?(folder)
    Capybara.page.driver.browser.save_screenshot(file)
    #attach_file(file, 'image/png')
  end
end


=begin
module Prints
    def take_screenshot(name_file, folder)
        file = "#{folder}/#{name_file}.png"
        FileUtils.mkdir_p(folder) unless File.exist?
        Capybara.page.driver.browser.save_screenshot(file)
        attach(file, 'image/png')
    end
end
=end