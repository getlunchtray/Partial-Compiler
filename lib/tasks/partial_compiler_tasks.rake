namespace :compiler do
  desc "Compiles your partials"
  task :run do
    PartialCompiler::Compiler.new
  end
end
