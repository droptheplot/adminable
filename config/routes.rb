Cms::Engine.routes.draw do
  Cms::Configuration.resources.each do |resources|
    resources resources[:name], except: :show, path: resources[:path], controller: resources[:path]
  end

  root 'dashboard#index'
end
