module PartialCompiler 
  TEMPLATE_ENGINE = ActionView::Template::Handlers::ERB
  ORIGINAL_EXTENSION = "html.erb"
  RENDERING_ENGINE_PARTIAL_FORMAT = "= render partial:"

  class Plugin 
    if Rails.env.development?
      ActionView::Template.register_template_handler(
        "uc.#{ORIGINAL_EXTENSION}".to_sym, "uncompiled.#{ORIGINAL_EXTENSION}".to_sym, 
        TEMPLATE_ENGINE.send(:new)
      )
    else
      ActionView::Template.register_template_handler("compiled.#{ORIGINAL_EXTENSION}".to_sym, TEMPLATE_ENGINE.send(:new))
    end
  end
end

require "partial_compiler/compiler"

