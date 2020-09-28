# frozen_string_literal: true
require_relative 'phonetic'

module AppHelpers

  def phonetic(id)
    Phonetic.spelling(id).join('<br/>');
  end

end
