require 'streamio-ffmpeg'

module Vimeo
  class Utils

    def self.insert_logo(file_path, logo_path, new_file_path = nil)
      check_file_exists(file_path, :video)
      check_file_exists(logo_path, :logo_image)

      new_file_path ||= file_with_logo_path(file_path)
      File.remove(new_file_path) if File.exist?(new_file_path)

      `ffmpeg -i #{file_path} -i #{logo_path} -filter_complex "[0:v][1:v]overlay" -codec:a copy #{new_file_path}`
      new_file_path
    end

    def self.duration(file)
      check_file_exists(file, :video)
      movie = FFMPEG::Movie.new(file)
      movie.duration
    end

    private

      def self.check_file_exists(file_path, type)
        unless File.exist?(file_path)
          raise FileNotFound, "#{type.to_s.capitalize} file does not exist: #{file_path}"
        end
      end

      def self.file_with_logo_path(path)
        if path =~ /(\.\w{3,4})$/
          path.gsub(/(\.\w{3,4})$/, "withlogo#{$1}")
        else
          path
        end
      end
  end
end
