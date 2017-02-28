require "safe_ruby"
require "find"

module PartialCompiler
  class PartialReader
    attr_accessor :path, :locals, :contents, :indentation
    
    #  @path: Where the partial file is located
    #  @locals: The locals set in the uncompiled file
    #  @contents: The actual guts of the partial which will be placed in the compiled file
    #  @indentation: The indentation on the line where 'render partial' is called

    def initialize original_string, file_called_from 
      code_to_eval = original_string.match(PartialCompiler.config[:regex_partial_eval_match])[1]
      path_to_partial, partial_name, @locals = execute_safe_ruby(code_to_eval)
      set_path(path_to_partial, partial_name, file_called_from)
      get_indentation(original_string)
      set_contents(@indentation)
    end

    private

    def execute_safe_ruby code_to_eval
      render_method = "def render *args
        arguments = args[0]
        split_partial_name = arguments[:partial].split('/')
        return split_partial_name[0...-1], split_partial_name[-1], arguments[:locals]
      end
      #{code_to_eval}"
      partial_name, locals = SafeRuby.eval(render_method)
    end

    def set_path(path_to_partial, partial_name, calling_file)
      # Find a file in the same directory as the parent
      calling_file_path = calling_file.split("/")[0...-1].join("/")
      path_to_search = [calling_file_path, path_to_partial].compact.join("/")
      @path = find_file_in_path(partial_name, path_to_search)
      # If the path hasn't been found by now, it's likely because it's a layout file
      if !@path
        path_to_search = [Rails.root.join("app", "views"), path_to_partial].compact.join("/")
        @path = find_file_in_path(partial_name, path_to_search)
      end
    end

    def get_indentation original_string
      @indentation = original_string[/\A */].size
    end

    def set_contents indentation
      if @path 
        file = File.open(@path, "rb")
        @contents = add_indentation(file.read, indentation)
        file.close
      else 
        return nil
      end
    end 

    def add_indentation contents, indentation
      return (" " * indentation) + contents.gsub("\n", "\n" + (" " * indentation)).strip + "\n"
    end 

    def find_file_in_path file_name, path_to_search
      Find.find(path_to_search) do |path|
        return path if path =~ /_(#{file_name})/
      end rescue nil
    end

  end
end
