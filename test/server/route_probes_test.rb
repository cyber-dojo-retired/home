# frozen_string_literal: true
require_relative 'test_base'
require 'ostruct'

class RouteProbesTest < TestBase

  def self.id58_prefix
    'a86'
  end

  # - - - - - - - - - - - - - - - - -
  # 200
  # - - - - - - - - - - - - - - - - -

  test 'C15', %w(
  |GET/alive?
  |has status 200
  |returns true
  |and nothing else
  ) do
    assert_get_200_json(path='alive?') do |response|
      assert_equal [path], response.keys, "keys:#{last_response.body}:"
      assert true?(response[path]), "true?:#{last_response.body}:"
    end
  end

  # - - - - - - - - - - - - - - - - -

  test 'D15', %w(
  |when all http-services are ready
  |GET/ready?
  |has status 200
  |returns true
  |and nothing else
  ) do
    assert_get_200_json(path='ready?') do |response|
      assert_equal [path], response.keys, "keys:#{last_response.body}:"
      assert true?(response[path]), "true?:#{last_response.body}:"
    end
  end

  # - - - - - - - - - - - - - - - - -

  test 'E15', %w(
  |when model http-service is not ready
  |GET/ready?
  |has status 200
  |returns false
  |and nothing else
  ) do
    externals.instance_exec { @model=STUB_READY_FALSE }
    assert_get_200_json(path='ready?') do |response|
      assert_equal [path], response.keys, "keys:#{last_response.body}:"
      assert false?(response[path]), "false?:#{last_response.body}:"
    end
  end

  test 'E16', %w(
  |when avatars http-service is not ready
  |GET/ready?
  |has status 200
  |returns false
  |and nothing else
  ) do
    externals.instance_exec { @avatars=STUB_READY_FALSE }
    assert_get_200_json(path='ready?') do |response|
      assert_equal [path], response.keys, "keys:#{last_response.body}:"
      assert false?(response[path]), "false?:#{last_response.body}:"
    end
  end

  # - - - - - - - - - - - - - - - - -

  test 'F16', %w(
  |GET/alive?
  |is used by external k8s probes
  |so obeys Postel's Law
  |and ignores any passed arguments
  ) do
    assert_get_200_json('alive?arg=unused') do |response|
      assert_equal ['alive?'], response.keys, "keys:#{last_response.body}:"
      assert true?(response['alive?']), "true?:#{last_response.body}:"
    end
  end

  # - - - - - - - - - - - - - - - - -

  test 'F17', %w(
  |GET/ready?
  |is used by external k8s probes
  |so obeys Postel's Law
  |and ignores any passed arguments
  ) do
    assert_get_200_json('ready?arg=unused') do |response|
      assert_equal ['ready?'], response.keys, "keys:#{last_response.body}:"
      assert true?(response['ready?']), "true?:#{last_response.body}:"
    end
  end

  private

  STUB_READY_FALSE = OpenStruct.new(:ready? => false)

  def true?(b)
    b.instance_of?(TrueClass)
  end

  def false?(b)
    b.instance_of?(FalseClass)
  end

end
