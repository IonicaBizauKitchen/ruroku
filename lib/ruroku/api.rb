module Ruroku
  # Public: API object, holding a connection with Heroku API, and prociding
  # access to top-level resources (apps, keys, user).
  class API
    attr_accessor :heroku_api

    def initialize(options = {})
      self.heroku_api = Heroku::API.new options
    end

    # Public: Get apps associated with current heroku account.
    def apps
      @apps ||= AppSet.new heroku_api
    end

    # Public: Get specific app.
    #
    # Examples
    #
    #   heroku.app 'app-name'
    #   heroku['app-name']
    def app(app_name)
      App.new heroku_api, heroku_api.get_app(app_name).body
    end
    alias :[] :app

    # Public: Get keys associated with current heroku account.
    def keys
      @keys ||= KeySet.new heroku_api
    end

    # Public: Get User object associated with current heroku account.
    def user
      @user ||= User.new heroku_api, heroku_api.get_user.body
    end

    def inspect
      "<#{self.class}>"
    end
  end
end
