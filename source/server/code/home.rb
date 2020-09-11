# frozen_string_literal: true

class Home

  def initialize(externals)
    @externals = externals
  end

  def id_valid?(args)
    id = args['id']
    model.group_exists?(id) || model.kata_exists?(id)
  end

  private

  def model
    @externals.model
  end

end
