Adminable::Engine.routes.draw do
  Adminable::Configuration.resources.each do |r|
    resources r.route, except: :show, path: r.name, controller: r.name
  end

  root to: redirect(Adminable::Configuration.resources.first.name)
end
