module PartialCompiler 
  class Plugin 
    original_extension = PartialCompiler.config[:original_extension]
    template_engine = PartialCompiler.config[:template_engine]
    if Rails.env.development?
      ActionView::Template.register_template_handler(
        "uc.#{original_extension}".to_sym, "uncompiled.#{original_extension}".to_sym, 
        template_engine.send(:new)
      )
    else
      ActionView::Template.register_template_handler("compiled.#{original_extension}".to_sym, template_engine.send(:new))
    end
  end
end

require "partial_compiler/compiler"

