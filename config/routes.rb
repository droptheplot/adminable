Adminable::Engine.routes.draw do
  Adminable.resources.each do |r|
    resources r.route, except: :show, path: r.name, controller: r.name
  end

  root to: redirect(Adminable::Configuration.redirect_root_path)
end
