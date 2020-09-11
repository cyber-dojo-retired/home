# frozen_string_literal: true
require_relative 'external_avatars'
require_relative 'external_http'
require_relative 'external_model'

class Externals

  def avatars
    @avatars ||= ExternalAvatars.new(avatars_http)
  end
  def avatars_http
    @avatars_http ||= ExternalHttp.new
  end

  def model
    @model ||= ExternalModel.new(model_http)
  end
  def model_http
    @model_http ||= ExternalHttp.new
  end

end
