# frozen_string_literal: true
require_relative 'app_base'
require_relative 'probe'
require_relative 'helpers/app_helpers'

class App < AppBase

  def initialize(externals)
    super()
    @externals = externals
  end

  attr_reader :externals

  get_probe(:alive?) # curl/k8s
  get_probe(:ready?) # curl/k8s
  get_probe(:sha)    # identity

  def probe
    Probe.new(externals)
  end

  # - - - - - - - - - - - - - - - - - - - - -

  get '/index', provides:[:html] do
    respond_to do |format|
      format.html do
        erb :index
      end
    end
  end

  helpers AppHelpers

end
