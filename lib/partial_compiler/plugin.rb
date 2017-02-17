module PartialCompiler 
  class Plugin 
    erb_instance = ActionView::Template::Handlers::ERB.new
    if Rails.env.development?
      ActionView::Template.register_template_handler("uc.erb".to_sym", uncompiled.erb".to_sym, erb_instance)
    else
      ActionView::Template.register_template_handler("compiled.erb".to_sym, erb_instance)
    end
  end
end

