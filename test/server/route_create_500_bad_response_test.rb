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

  private

  def assert_get_500_json_exception(response, path)
    stub_model_http(response)
    assert_get_500_json(path) do |response|
      assert_equal [ 'exception' ], response.keys.sort, last_response.body
    end
  end

end
