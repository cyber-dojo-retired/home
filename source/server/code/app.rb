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
        id = params['id']
        @manifest = model.group_manifest(id)
        erb :'group/show'
      end
    end
  end

  get '/avatar', provides:[:html] do
    respond_to do |format|
      format.html do
        id = params['id']
        @manifest = model.kata_manifest(id)
        erb :'avatar/show'
      end
    end
  end

  get '/individual', provides:[:html] do
    respond_to do |format|
      format.html do
        id = params['id']
        @manifest = model.kata_manifest(id)
        erb :'individual/show'
      end
    end
  end

  helpers AppHelpers

  private

  def model
    @externals.model
  end

end
