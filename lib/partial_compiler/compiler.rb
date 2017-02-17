require 'find'

module PartialCompiler
  class Compiler
    def self.create_files
      find_files_by_extension.each do |file|
        compiled_file_path = find_compiled_file(file)
        find_partials(compiled_file_path)
      end
    end

    private

    def self.find_files_by_extension
      views_directory = Rails.root.join("app", "views")
      Find.find(views_directory).select do |p| 
        /.*\.uc.#{ORIGINAL_EXTENSION}$|.*\.uncompiled.#{ORIGINAL_EXTENSION}$/ =~ p 
      end
    end

    def self.find_compiled_file file_path
      compiled_file_path = file_path.gsub(/uc|uncompiled/, "compiled")
      FileUtils.cp(file_path, compiled_file_path)
      return compiled_file_path
    end

    def self.find_partials compiled_file_path
      text = File.open(compiled_file_path).read
      text.each_line do |line|
        if line.include? RENDERING_ENGINE_PARTIAL_FORMAT 
          puts "Partial Found\n"
        else
          puts "Partial Not Found\n"
        end
      end
    end
  end
end
