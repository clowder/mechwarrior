require 'mechanize'

class Capybara::Mechanize::Browser
  attr_reader :agent
  
  def initialize
    @agent = Mechanize.new do |config|
      config.follow_meta_refresh = true
      config.redirection_limit   = 5
    end
  end
  
  def get(url)  
    referrer = been_somewhere? ? self.url : nil
    @agent.get(url, [], referrer)
  end
  
  def post(url); @agent.post(url); end
  def put(url); @agent.get(url); end
  def delete(url); @agent.delete(url); end
  def submit(form); @agent.submit(form); end
  
  def uri
    been_somewhere? ? @agent.current_page.uri : nil
  end
  
  def url
    uri.nil? ? '' : uri.to_s
  end
  
  def headers
    been_somewhere? ? @agent.current_page.header : {}
  end
  
  def status_code
    been_somewhere? ? @agent.current_page.code.to_i : nil
  end
  
  def dom
    been_somewhere? ? @agent.current_page.root : Nokogiri::HTML(nil)
  end
  
  def source
    been_somewhere? ? @agent.current_page.body : ''
  end
  
  def been_somewhere?
    !@agent.current_page.nil?
  end
end
