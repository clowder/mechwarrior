require 'mechanize'

class Capybara::Mechanize::Form < Mechanize::Form

  def initialize(driver, form_node)
    @driver   = driver
    form_node = form_node.clone

    form_node.search('*[disabled=disabled]').remove

    super(form_node, @driver.browser.agent)
  end

  def submit(button_node)
    button        = Mechanize::Form::Button.new(button_node)
    resolve_action(@driver.current_url)

    self.normalize_uploads!
    self.add_button_to_query(button)
    @driver.submit(self)
  end

  protected

  def normalize_uploads!
    self.file_uploads.each do |upload|
      file_path = upload.node["value"]
      next if file_path.nil? || file_path == ''

      if self.multipart?
        upload.file_name = file_path 
      else
        new_field = Mechanize::Form::Field.new(upload.node, File.basename(file_path))
        self.fields << new_field
      end
    end
  end

  def multipart?
    !!(self.enctype.downcase =~ /^multipart\/form-data/)
  end  

  private

  def resolve_action(current_url)
    if self.method.upcase == 'GET' and self.action !~ /^http/ and self.action.to_s != ""
      uri = URI.parse(current_url)
      self.action = "#{uri.scheme}://#{uri.host}:#{uri.port}#{self.action}"
    else
      self.action ||= current_url
    end
  end
end
