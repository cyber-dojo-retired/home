# frozen_string_literal: true
require_relative 'http_json_hash/service'

class ExternalSaver

  def initialize(http)
    service = 'saver'
    port = ENV['CYBER_DOJO_SAVER_PORT'].to_i
    @http = HttpJsonHash::service(self.class.name, http, service, port)
  end

  def dir_exists_command(dirname)
    ['dir_exists?',dirname]
  end

  def file_read_command(filename)
    ['file_read',filename]
  end

  def run(command)
    @http.post(__method__, { command:command })
  end

end
