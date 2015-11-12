require 'helper'

class TestVimeo < Test::Unit::TestCase

  def setup
    @vimeo = Vimeo::Base.new(access_token: ACCESS_TOKEN)
    @remote_video_url = 'http://www.w3schools.com/html/mov_bbb.mp4'
    @old_video_path = File.join(File.dirname(__FILE__), 'files', 'mov_bbb.mp4')
    @new_video_path = File.join(File.dirname(__FILE__), 'files', 'mov_bbb_withlogo.mp4')
    @logo_path = File.join(File.dirname(__FILE__), 'files', 'logo.png')
  end

  should "get endpoints" do
    resp = @vimeo.get('/')
    assert_equal resp.keys, ["endpoints"]
  end

  should "upload remote video to account and delete it" do
    resp = @vimeo.upload(type: 'pull', link: @remote_video_url)
    json_response = JSON.parse(resp)

    assert_not_nil json_response["link"]

    uri = json_response["uri"]
    @vimeo.delete(uri)
  end

  should "add logo to new file" do
    assert_equal true, File.exists?(@old_video_path)
    assert_equal false, File.exists?(@new_video_path)

    Vimeo::Utils.insert_logo(@old_video_path, @logo_path, @new_video_path)

    assert_equal true, File.exists?(@old_video_path)
    assert_equal true, File.exists?(@new_video_path)

    assert_operator File.size(@old_video_path), :!=, File.size(@new_video_path)

    File.delete(@new_video_path)
  end

end
