namespace :compiler do
  desc "Compiles your partials"
  task :run => :environment do
    PartialCompiler::Compiler.new
  end
end
