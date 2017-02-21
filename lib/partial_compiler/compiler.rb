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
      text.each_line do |line|
        if line.include? RENDERING_ENGINE_PARTIAL_FORMAT 
          PartialReader.new(line, compiled_file_path)
          puts "Partial Found\n"
        else
          puts "Partial Not Found\n"
        end
      end
    end
  end
end
