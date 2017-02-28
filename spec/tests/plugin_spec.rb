require "spec_helper"

module PartialCompiler
  describe Compiler do
    context "development" do
      it "registers uncompiled handlers" do
        expected_handlers = ["uncompiled.html.erb", "uc.html.erb"]
        current_handlers = ActionView::Template.template_handler_extensions
        expect(expected_handlers & current_handlers).to match_array(expected_handlers) 
      end
    end

    context "production" do
      it "registers compiled handler in production" do
        PartialCompiler.configure({run_compiled: true})
        PartialCompiler.start
        expected_handlers = ["compiled.html.erb"]
        current_handlers = ActionView::Template.template_handler_extensions
        expect(expected_handlers & current_handlers).to match_array(expected_handlers) 
      end
    end
  end
end

module PartialCompiler
  describe Compiler do
  end
end
