require 'httparty'

module Vimeo
  class Base
    include HTTParty
    base_uri 'https://api.vimeo.com/'

    attr_accessor :version, :access_token

    def initialize(options = {})
      @version = options[:version] || "3.2"
      @access_token = options[:access_token]

      @headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/vnd.vimeo.*+json;version=#{@version}"
      }
      @headers["Authorization"] = "bearer #{@access_token}" if @access_token
    end

    [:get, :post, :put, :patch, :delete].each do |action|
      define_method(action) do |*args|
        if args.length < 1 or args.length > 2
          exception_msg = "#{action} should be called with url, options = {}"
          raise ArgumentError, exception_msg
        end
        body = {body: JSON.dump(args[1] || {})}
        args[1] = {headers: @headers}.merge(body)
        self.class.send(action, *args)
      end
    end

  end
end
