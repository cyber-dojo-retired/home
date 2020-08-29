# frozen_string_literal: true
require_relative 'external_home'
require_relative 'external_http'
require_relative 'external_saver'

class Externals

  def home
    @home ||= ExternalHome.new(home_http)
  end
  def home_http
    @home_http ||= ExternalHttp.new
  end

  def saver
    @saver ||= ExternalSaver.new(saver_http)
  end
  def saver_http
    @saver_http ||= ExternalHttp.new
  end

end
