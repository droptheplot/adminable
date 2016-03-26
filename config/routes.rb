Cms::Engine.routes.draw do
  Cms::Configuration.resources.each do |r|
    resources r.route, except: :show, path: r.name, controller: r.name
  end

  root 'application#welcome'
end
