# frozen_string_literal: true

class Probe

  def initialize(externals)
    @externals = externals
  end

  def alive?(_params)
    true
  end

  def ready?(_params)
    [ @externals.model ].all?(&:ready?)
  end

  def sha(_params)
    ENV['SHA']
  end

end
