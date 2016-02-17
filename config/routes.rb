Cms::Engine.routes.draw do
  Cms::Configuration.resources_names.each do |resource_name|
    resources resource_name.split('/').last, except: :show, path: resource_name, controller: resource_name
  end

  root 'application#boards'
end
