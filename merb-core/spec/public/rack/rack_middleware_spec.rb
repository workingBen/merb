require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))
startup_merb

require File.join(File.dirname(__FILE__), "shared_example_groups")

class RackyController < Merb::Controller
  def index
    body = "Everyone loves Rack"
    headers['Content-Length'] = body.size.to_s
    
    body
  end
end

Merb::Router.prepare do
  match("/heavy/lifting").to(:controller => "racky_controller")
end


describe Merb::Rack::Application do
  before(:each) do
    @app = Merb::Rack::Application.new
    @env = Rack::MockRequest.env_for('/heavy/lifting')
    
    @result = @app.call(@env)
    @body   = "Everyone loves Rack"
  end

  it_should_behave_like "rack application"

  it 'does not set Date header' do
    status, headers, body = @app.call(@env)

    headers.keys.should_not include(Merb::Const::DATE)
  end
  
  describe "#deferred?" do
    it "returns true when request path matches deferred actions regexp" do
      Merb::Config[:deferred_actions] = ['/heavy/lifting']

      @app.deferred?(@env).should be(true)
    end

    it "returns false when request path DOES NOT match deferred actions regexp" do
      @app.deferred?(Rack::MockRequest.env_for('/not/deferred')).should be(false)
    end
  end
end


describe Merb::Rack::Middleware do
  before(:each) do
    @app = Merb::Rack::Application.new
    @middleware = Merb::Rack::Middleware.new(@app)
    @env        = Rack::MockRequest.env_for('/heavy/lifting')
    
    @result = @middleware.call(@env)
    @body   = "Everyone loves Rack"
  end

  it_should_behave_like "rack application"

  it_should_behave_like "transparent middleware"
end



describe Merb::Rack::Tracer do
  before(:each) do
    @app = Merb::Rack::Application.new
    @middleware = Merb::Rack::Tracer.new(@app)
    @env        = Rack::MockRequest.env_for('/heavy/lifting')
    
    @result = @middleware.call(@env)
    @body   = "Everyone loves Rack"
  end

  it_should_behave_like "rack application"

  it_should_behave_like "transparent middleware"  
end


describe Merb::Rack::ContentLength do
  before(:each) do
    @app = Merb::Rack::Application.new
    @middleware = Merb::Rack::ContentLength.new(@app)
    @env        = Rack::MockRequest.env_for('/heavy/lifting')
    
    @result = @middleware.call(@env)
    @body   = "Everyone loves Rack"
  end

  it_should_behave_like "rack application"

  it_should_behave_like "transparent middleware"

  it 'sets Content-Length header to response body size' do
    @result[1]['Content-Length'].should == @body.size.to_s
  end
end

describe Merb::Rack::Head do
  before(:each) do
    @app = Merb::Rack::Application.new
    @middleware = Merb::Rack::Head.new(@app)
    @env        = Rack::MockRequest.env_for('/heavy/lifting', :method => 'HEAD')
    
    @result = @middleware.call(@env)
    @body   = [] # Head should return empty body
  end

  it_should_behave_like "rack application"

  it_should_behave_like "transparent middleware"
end
