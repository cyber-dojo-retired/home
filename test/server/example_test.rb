require_relative 'test_base'

class ExampleTest < TestBase

  def self.id58_prefix
    '449'
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - -

  def id58_setup
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'AC6', %w( example ) do
    stdout,stderr = capture_stdout_stderr {
      $stdout.puts('hello')
      assert_equal 42, 42
    }
    assert_equal "hello\n", stdout
    assert_equal '', stderr
  end

end
