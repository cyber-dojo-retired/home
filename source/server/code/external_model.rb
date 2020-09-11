# frozen_string_literal: true
require_relative 'http_json_hash/service'

class ExternalModel

  def initialize(http)
    name = 'model'
    port = ENV['CYBER_DOJO_MODEL_PORT'].to_i
    @http = HttpJsonHash::service(self.class.name, http, name, port)
  end

  def ready?
    @http.get(__method__, {})
  end

  # - - - - - - - - - - - - - - - - - - -

  def group_exists?(id)
    @http.get(__method__, { id:id })
  end

  def group_manifest(id)
    @http.get(__method__, { id:id })
  end

  # - - - - - - - - - - - - - - - - - - -

  def kata_exists?(id)
    @http.get(__method__, { id:id })
  end

  def kata_manifest(id)
    @http.get(__method__, { id:id })
  end

end
