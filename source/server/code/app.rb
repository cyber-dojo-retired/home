# frozen_string_literal: true
require_relative 'app_base'
require_relative 'helpers/app_helpers'
require_relative 'home'
require_relative 'probe'

class App < AppBase

  def initialize(externals)
    super(externals)
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get_route(:alive?, Probe)
  get_route(:ready?, Probe)
  get_route(:sha,    Probe)

  # - - - - - - - - - - - - - - - - - - - - -

  get '/index', provides:[:html] do
    respond_to do |format|
      format.html do
        @id = params['id'] || ''
        erb :'home/show'
      end
    end
  end

  get_route(:id_valid?, Home)

  # - - - - - - - - - - - - - - - - - - - - -

  get '/group', provides:[:html] do
    respond_to do |format|
      format.html do
        @id = params['id'] || ''
        erb :'group/show'
      end
    end
  end

  get '/avatar', provides:[:html] do
    respond_to do |format|
      format.html do
        @id = params['id'] || ''
        erb :'avatar/show'
      end
    end
  end

  get '/individual', provides:[:html] do
    respond_to do |format|
      format.html do
        @id = params['id'] || ''
        erb :'individual/show'
      end
    end
  end

  helpers AppHelpers

end
