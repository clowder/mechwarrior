class Capybara::Mechanize::Node < Capybara::RackTest::Node
  def click
    if tag_name == 'a'
      method = self["data-method"] || :get
      href = self[:href].to_s
      href = "/#{href}" if href !~ /^\/|^#|^\?|^http/
      driver.follow(method, href)
    elsif (tag_name == 'input' and %w(submit image).include?(type)) or
      ((tag_name == 'button') and type.nil? or type == "submit")
      Capybara::Mechanize::Form.new(driver, form).submit(self)
    end
  end  
end
