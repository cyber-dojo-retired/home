# frozen_string_literal: true
require_relative 'phonetic'

module AppHelpers

  def phonetic(id)
    letters = Phonetic.spelling(id)
    lhs = letters[0..2].join('-')
    rhs = letters[3..-1].join('-')
    lhs + '<br/>' + rhs
  end

end
