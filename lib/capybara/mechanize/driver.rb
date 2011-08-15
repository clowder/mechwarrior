class Capybara::Mechanize::Driver < Capybara::Driver::Base
  attr_reader :app, :rack_server, :options

  def initialize(app, options={})
    raise ArgumentError, "Mechanize requires a rack application, but none was given" unless app
    
    @app         = app
    @options     = options
    @rack_server = Capybara::Server.new(@app)
    @rack_server.boot if Capybara.run_server
  end

  def browser
    @browser ||= Capybara::Mechanize::Browser.new
  end

  def visit(path)
    browser.get(url(path))
  end

  def follow(_method, path)
    return if is_fragment?(path)
    browser.send(_method, make_absolute_url(path))
  end

  def submit(form)
    browser.submit(form)
  end

  def current_url
    browser.url
  end

  def response_headers
    browser.headers
  end

  def status_code
    browser.status_code
  end

  def find(selector)
    dom.search(selector).map { |node| Capybara::Mechanize::Node.new(self, node) }
  end

  def source
    browser.source
  end
  alias :body :source

  def dom
    browser.dom
  end

  def reset!
    @browser = nil
  end

  private
  
  def make_absolute_url(path)
    return path unless URI.parse(path).relative?

    path = "#{ browser.uri.path }#{ path }" if is_query_string?(path)

    if browser.been_somewhere? && current_page_is_external?
      external_url(path)
    else
      url(path)
    end
  end
  
  def external_url(path)
    browser.uri.merge(path).to_s  
  end
  
  def url(path)
    rack_server.url(path)
  end

  def current_page_is_external?
    browser.uri.host != (rack_server.host || URI.parse(Capybara.app_host).host)
  end
  
  def is_query_string?(path)
    browser.been_somewhere? && path.start_with?('?')
  end

  def is_fragment?(path)
    browser.been_somewhere? && path.gsub(/^#{browser.uri.path}/, '').start_with?('#')
  end
end
