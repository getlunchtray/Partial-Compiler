require 'find'

module PartialCompiler
  class Compiler
    attr_accessor :files

    def initialize
      @files = FileCopier.create_files
      @files.each do |file|
        find_partials(file) 
      end
    end

    private

    def find_partials compiled_file_path
      text = File.open(compiled_file_path).read
      compiled_content = ""
      text.each_line do |line|
        compiled_content += read_each_line(line, compiled_file_path)
      end
      compiled_content.to_s.encode('UTF-8', {
        :invalid => :replace,
        :undef   => :replace,
        :replace => '?'
      })
      File.open(compiled_file_path, "w") {|file| file.puts compiled_content }
    end

    def read_each_line line, compiled_file_path
      if line.include? RENDERING_ENGINE_PARTIAL_FORMAT 
        file = PartialReader.new(line, compiled_file_path)
        if file.contents
          locals_line = generate_locals(file.locals, line)
          content_with_locals = [locals_line, file.contents].compact.join("\n")
          return content_with_locals
        end
      end
      line
    end

    def generate_locals locals, original_line
      if locals
        condensed_locals = locals.map{|local, value| "#{local}=#{get_local_value(local, original_line)}"}.join(";")
        return "<% #{condensed_locals} %>"
      else
        return nil 
      end
    end

    def get_local_value local, original_line
      find_value_of_local = /#{local}:([^,}]*)/
      original_line.match(find_value_of_local)[-1]
    end

  end
end
