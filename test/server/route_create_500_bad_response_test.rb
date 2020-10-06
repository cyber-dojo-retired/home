# frozen_string_literal: true
require_relative 'test_base'

class RouteCreate500BadResponseTest < TestBase

  def self.id58_prefix
    'f28'
  end

  # - - - - - - - - - - - - - - - - -
  # 500
  # - - - - - - - - - - - - - - - - -

  test 'QN4', %w(
  |when an http-proxy
  |returns non-JSON in its response.body
  |its a 500 error
  ) do
    assert_get_500_json_exception('xxxx', 'ready?')
  end

  # - - - - - - - - - - - - - - - - -

  test 'QN5', %w(
  |when an http-proxy
  |returns JSON (but not a Hash) in its response.body
  |its a 500 error
  ) do
    assert_get_500_json_exception('[]', 'ready?')
  end

  # - - - - - - - - - - - - - - - - -

  test 'QN6', %w(
  |when an http-proxy
  |returns JSON-Hash in its response.body
  |which contains the key "exception"
  |its a 500 error
  ) do
    assert_get_500_json_exception('{"exception":42}', 'ready?')
  end

  # - - - - - - - - - - - - - - - - -

  test 'QN7', %w(
  |when an http-proxy
  |returns JSON-Hash in its response.body
  |which does not contain the requested method's key
  |its a 500 error
  ) do
    assert_get_500_json_exception('{"wibble":42}', 'ready?')
  end

  # - - - - - - - - - - - - - - - - -

  test 'QN8', %w(
  |when an http-proxy
  |has a 500 error
  |there is useful diagnostic info
  ) do
    externals.instance_exec {
      @model_http = HttpAdapterStartRaiser.new
    }
    stdout,stderr = capture_io { get '/ready?' }
    assert status?(500)
    assert json_content?, content_type
    assert_equal '', stderr, :stderr
    assert_equal stdout, last_response.body+"\n", :stdout
    ex = json_response['exception']
    assert_equal '/ready', ex['request']['path'], json_response
    assert_equal '', ex['request']['body'], json_response
    refute_nil ex['backtrace'], json_response
    assert ex['message'].include?("undefined method `get'"), json_response
  end

  private

  def assert_get_500_json_exception(response, path)
    externals.instance_exec { @model_http = HttpAdapterStub.new(response) }
    assert_get_500_json(path) do |response|
      assert_equal [ 'exception' ], response.keys.sort, last_response.body
    end
  end

  # - - - - - - - - - - - - - - -

  class HttpAdapterStartRaiser
  end

  class HttpAdapterStub
    def initialize(body)
      @body = body
    end
    def get(_uri)
      OpenStruct.new
    end
    def start(_hostname, _port, _req)
      self
    end
    attr_reader :body
  end

end
