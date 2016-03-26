Cms::Engine.routes.draw do
  Cms::Configuration.resources.each do |r|
    resources r.route_name, except: :show, path: r.route_path,
                            controller: r.route_path
  end

  root 'application#dashboard'
end
