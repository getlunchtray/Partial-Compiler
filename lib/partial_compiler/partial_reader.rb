require "safe_ruby"

module PartialCompiler
  class PartialReader
    attr_accessor :path, :locals, :contents

    def initialize original_string, original_file
      @string_to_eval = original_string
      @parent_file = original_file
      set_path
      set_locals
      set_contents
    end

    private

    def set_path
      code_to_eval = @string_to_eval.match(/(render .*)%>/)[1]
      execute_safe_ruby code_to_eval 
      @parent_file
    end
  
    def set_contents
    end 

    def set_locals
    end

    def execute_safe_ruby code_to_eval
      render_method = "def render *args
        return args[0][:partial]
      end
      #{code_to_eval}"
      partial_name = SafeRuby.eval(render_method)
      binding.pry
    end
  end
end
