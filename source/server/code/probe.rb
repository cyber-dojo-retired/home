# frozen_string_literal: true

class Probe

  def initialize(externals)
    @externals = externals
  end

  def alive?(_args)
    true
  end

  def ready?(_args)
    dependents.all?(&:ready?)
  end

  def sha(_args)
    ENV['SHA']
  end

  private

  def dependents
    [ @externals.model,
      @externals.avatars
    ]
  end

end
