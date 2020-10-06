# frozen_string_literal: true
require_relative 'test_base'

class RouteEnterTest < TestBase

  def self.id58_prefix
    'd4P'
  end

  # - - - - - - - - - - - - - - - - -

  test 'x23', %w(
  |POST /enter.json
  |has status 200
  |returns JSON with route to avatar
  ) do
    assert_post_200_json('enter.json', {id:'chy6BJ'}) do |response|
      # eg response == {"route"=>"/home/avatar?id=TEbR8E"}
      assert %r"/home/avatar\?id=(?<id>.*)" =~ response['route'], response
      assert kata_exists?(id)
    end
  end

  # - - - - - - - - - - - - - - - - -

  test 'x24', %w(
  |POST /enter.json
  |has status 200
  |returns JSON with route to full page
  |when group is full
  ) do
    path = 'enter.json'
    data = {id:'FxWwrr'}
    64.times do
      post path, data.to_json, JSON_REQUEST_HEADERS
    end

    assert_post_200_json(path, data) do |response|
      # eg response == {"route"=>"/home/full?id=FxWwrr"}
      assert %r"/home/full\?id=(?<id>.*)" =~ response['route'], response
      assert_equal 'FxWwrr', id
    end
  end

end
