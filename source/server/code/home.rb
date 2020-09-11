# frozen_string_literal: true

class Home

  def initialize(externals)
    @externals = externals
  end

  def id_info(args)
    id = args['id']
    if model.group_exists?(id)
      "/home/group?id=#{id}"
    elsif model.kata_exists?(id)
      manifest = model.kata_manifest(id)
      if manifest.has_key?('group_id')
        "/home/avatar?id=#{id}"
      else
        "/home/individual?id=#{id}"
      end
    else
      false
    end
  end

  private

  def model
    @externals.model
  end

end
