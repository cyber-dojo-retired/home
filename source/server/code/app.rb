# frozen_string_literal: true
require_relative 'app_base'
require_relative 'helpers/app_helpers'
require_relative 'home'
require_relative 'probe'

class App < AppBase

  def initialize(externals)
    super(@externals = externals)
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get_delegate(:alive?, Probe)
  get_delegate(:ready?, Probe)
  get_delegate(:sha,    Probe)

  # - - - - - - - - - - - - - - - - - - - - -

  get '/index', provides:[:html] do
    respond_to do |format|
      format.html do
        @id = params['id'] || ''
        erb :home
      end
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get '/create', provides:[:html] do
    respond_to do |format|
      format.html do
        erb :create
      end
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get '/enter', provides:[:html] do
    respond_to do |format|
      format.html do
        @id = params['id'] || ''
        erb :enter
      end
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get_delegate(:id_type, Home)

  # - - - - - - - - - - - - - - - - - - - - -

  get '/group', provides:[:html] do
    respond_to do |format|
      format.html do
        @group_id = params['id']
        erb :group
      end
    end
  end

  post '/enter.json', provides:[:json] do
    respond_to do |format|
      format.json do
        group_id = json_body['id']
        kata_id = model.group_join(group_id)
        if kata_id.nil?
          route = "/home/full?id=#{group_id}"
        else
          route = "/home/avatar?id=#{kata_id}"
        end
        json({"route":route})
      end
    end
  end

  get '/full', provides:[:html] do
    respond_to do |format|
      format.html do
        @group_id = params['id']
        erb :full
      end
    end
  end

  get '/reenter', provides:[:html] do
    respond_to do |format|
      format.html do
        @group_id = params['id']
        @avatars = model.group_avatars(@group_id).to_h
        @avatars_names = avatars.names
        erb :reenter
      end
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get '/avatar', provides:[:html] do
    respond_to do |format|
      format.html do
        @kata_id = params['id']
        manifest = model.kata_manifest(@kata_id)
        @group_id = manifest['group_id']
        @index = manifest['group_index'].to_i
        @avatar_name = avatars.names[@index]
        erb :avatar
      end
    end
  end

  private

  helpers AppHelpers

  def json_body
    JSON.parse!(request.body.read)
  end

  def avatars
    @externals.avatars
  end

  def model
    @externals.model
  end

end
