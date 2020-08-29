# frozen_string_literal: true

class Home

  def initialize(externals)
    @externals = externals
  end

  # - - - - - - - - - - - - - - - - - - - - - -

  def ready?
    home.ready?
  end

  private

  def home
    @externals.home
  end

end
