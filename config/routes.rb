Cms::Engine.routes.draw do
  Cms::Configuration.resources_names.each do |resource_name|
    resources resource_name, except: :show
  end

  root 'application#boards'
end
