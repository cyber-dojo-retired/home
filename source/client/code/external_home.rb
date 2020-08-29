# frozen_string_literal: true
require_relative 'http_json_hash/service'

class ExternalHome

  def initialize(http)
    @http = HttpJsonHash::service(self.class.name, http, 'home-server', 4527)
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
