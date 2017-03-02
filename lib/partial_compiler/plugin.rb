module PartialCompiler 
  class Plugin 
    def initialize 
      original_extension = PartialCompiler.config[:original_extension]
      template_engine = get_template_engine
      if !PartialCompiler.config[:run_compiled]
        ActionView::Template.register_template_handler(
          "uc.#{original_extension}".to_sym, "uncompiled.#{original_extension}".to_sym, 
          template_engine.send(:new)
        )
      else
        ActionView::Template.register_template_handler("compiled.#{original_extension}".to_sym, template_engine.send(:new))
      end
    end

    private

    def get_template_engine
      template_engine_class = PartialCompiler.config[:template_engine]
      return "ActionView::Template::Handlers::#{template_engine_class}".constantize
    end
  end

  def self.start
    Plugin.new
  end
end

