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
        erb :'home/show'
      end
    end
  end

  get_delegate(:id_info, Home)

  # - - - - - - - - - - - - - - - - - - - - -

  get '/group', provides:[:html] do
    respond_to do |format|
      format.html do
        group_id = params['id']
        @manifest = model.group_manifest(group_id)
        erb :'group/show'
      end
    end
  end

  post '/join.json', provides:[:json] do
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
        group_id = params['id']
        @manifest = model.group_manifest(group_id)
        erb :'group/full'
      end
    end
  end

  get '/rejoin', provides:[:html] do
    respond_to do |format|
      format.html do
        group_id = params['id']
        @manifest = model.group_manifest(group_id)
        @avatars = model.group_avatars(group_id).to_h
        @avatars_names = avatars.names
        erb :'group/rejoin'
      end
    end
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get '/avatar', provides:[:html] do
    respond_to do |format|
      format.html do
        kata_id = params['id']
        @manifest = model.kata_manifest(kata_id)
        @index = @manifest['group_index'].to_i
        @name = avatars.names[@index]
        erb :'avatar/show'
      end
    end
  end

  get '/individual', provides:[:html] do
    respond_to do |format|
      format.html do
        kata_id = params['id']
        @manifest = model.kata_manifest(kata_id)
        erb :'individual/show'
      end
    end
  end

  helpers AppHelpers

  private

  def avatars
    @externals.avatars
  end

  def model
    @externals.model
  end

end
