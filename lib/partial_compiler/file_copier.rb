require 'find'

module PartialCompiler
  class FileCopier
    def self.create_files
      files_to_compile = []
      find_files_by_extension.each do |file|
        compiled_file_path = find_compiled_file(file)
        files_to_compile << compiled_file_path
      end
      files_to_compile
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

  end
end
