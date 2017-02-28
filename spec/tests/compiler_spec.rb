require "spec_helper"
require "expected_file_contents"

module PartialCompiler
  describe Compiler do
    let(:compiler){ PartialCompiler::Compiler.new }
    let(:base_file_path){Rails.root.join("app", "views", "items")}

    context "find_partials" do
      it "sets compiled files" do
        expect(compiler.files.include?(base_file_path.join("index.compiled.html.erb").to_s)).to be true
      end  

      # Expected files (one for each test in file compilation context):
      # basic, contains_bad_file_path, different_file, indentation, index, multiple, with_locals 
      it "compiles all the required files" do
        expect(compiler.files.count).to eq(7)
        expect(compiler.files.include?(Rails.root.join(
          "app", 
          "views", 
          "items", 
          "dont_compile.compiled.html.erb"
        ).to_s)).to be false 
      end
    end

    # Add expected file contents to hash in spec/expected_file_contents.rb
    context "file compilation" do
      it "performs a basic compilation" do
        file_path = base_file_path.join("basic.compiled.html.erb") 
        expect(File.open(file_path, "r").read.chomp).to eq(expected_file_contents_for("basic"))
      end

      it "handles multiple files" do
        file_path = base_file_path.join("multiple.compiled.html.erb") 
        expect(File.open(file_path, "r").read.chomp).to eq(expected_file_contents_for("multiple"))
      end

      it "handles locals" do
        file_path = base_file_path.join("with_locals.compiled.html.erb") 
        expect(File.open(file_path, "r").read.chomp).to eq(expected_file_contents_for("with_locals"))
      end

      it "handles indentation" do
        file_path = base_file_path.join("indentation.compiled.html.erb") 
        expect(File.open(file_path, "r").read.chomp).to eq(expected_file_contents_for("indentation"))
      end

      it "compiles a file in different directory" do
        file_path = base_file_path.join("different_file.compiled.html.erb") 
        expect(File.open(file_path, "r").read.chomp).to eq(expected_file_contents_for("different_file"))
      end

      it "handles a file not being found" do
        file_path = base_file_path.join("contains_bad_file_path.compiled.html.erb") 
        expect(File.open(file_path, "r").read.chomp).to eq(expected_file_contents_for("contains_bad_file_path"))
      end
    end
  end
end
