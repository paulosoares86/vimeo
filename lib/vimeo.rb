require "vimeo/base"
require "vimeo/utils"
require "vimeo/exceptions"

module Vimeo

  class Base
    def upload(options)
      post('/me/videos', options)
    end
  end

end
