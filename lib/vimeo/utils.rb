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

      if new_file_path.nil?
        new_file_path = file_path
      elsif File.exist?(new_file_path)
        File.remove(new_file_path)
      end

      `ffmpeg -i #{file_path} -i #{logo_path} -filter_complex "[0:v][1:v]overlay" -codec:a copy #{new_file_path}`
    end
  end
end
