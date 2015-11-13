require "vimeo/base"
require "vimeo/utils"

module Vimeo

  class Base
    def upload(options)
      post('/me/videos', options)
    end
  end
  
end
