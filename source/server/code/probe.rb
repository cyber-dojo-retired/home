# frozen_string_literal: true

class Probe # k8s/curl probing + identity

  def initialize(externals)
    @externals = externals
  end

  def alive?
    true
  end

  def ready?
    [ @externals.saver ].all?(&:ready?)
  end

  def sha
    ENV['SHA']
  end

end
