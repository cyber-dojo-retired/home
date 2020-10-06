require_relative 'test_base'

class ViewsTest < TestBase

  def self.id58_prefix
    '449'
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - -

  def id58_setup
    @group_id = 'chy6BJ'
    @kata_id = '5rTJv5'
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'AC1', %w( GET /home/index 200 ) do
    assert_get_200_html('/home/index')
  end

  test 'AC2', %w( GET /home/enter 200 ) do
    assert_get_200_html("/home/enter?id=#{@group_id}")
    assert_get_200_html("/home/enter?id=#{@kata_id}")
    assert_get_200_html("/home/enter")
  end

  test 'AC3', %w( GET /home/avatar 200 ) do
    assert_get_200_html("/home/avatar?id=#{@kata_id}")
  end

  test 'AC4', %w( GET /home/reenter 200 ) do
    assert_get_200_html("/home/reenter?id=#{@group_id}")
  end

  test 'AC5', %w( GET /home/full 200 ) do
    assert_get_200_html("/home/full?id=#{@group_id}")
  end

end
