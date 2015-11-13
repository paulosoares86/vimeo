module Vimeo
  class Utils

    def self.insert_logo(file_path, logo_path, new_file_path = nil)

      unless File.exist?(file_path)
        exception_msg = "Cannot add logo to video because path does not exist: #{file_path}"
        raise Exception, exception_msg
      end

      unless File.exist?(logo_path)
        exception_msg = "Cannot add logo to video because path does not exist: #{logo_path}"
        raise Exception, exception_msg
      end

      new_file_path ||= file_with_logo_path(file_path)
      File.remove(new_file_path) if File.exist?(new_file_path)

      `ffmpeg -i #{file_path} -i #{logo_path} -filter_complex "[0:v][1:v]overlay" -codec:a copy #{new_file_path}`
      new_file_path
    end

    private

      def self.file_with_logo_path(path)
        if path =~ /(\.\w{3,4})$/
          path.gsub(/(\.\w{3,4})$/, "withlogo#{$1}")
        else
          path
        end
      end
  end
end
