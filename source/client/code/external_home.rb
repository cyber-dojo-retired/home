# frozen_string_literal: true
require_relative 'http_json_hash/service'

class ExternalHome

  def initialize(http)
    service = 'home-server'
    port = ENV['CYBER_DOJO_HOME_PORT'].to_i
    @http = HttpJsonHash::service(self.class.name, http, service, port)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  def alive?
    @http.get(__method__, {})
  end

  def ready?
    @http.get(__method__, {})
  end

  def sha
    @http.get(__method__, {})
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

end
