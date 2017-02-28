#:nocov:
require 'rails'

module PartialCompiler 
  class Railtie < Rails::Railtie
    railtie_name :parital_compiler

    rake_tasks do
      load 'tasks/partial_compiler_tasks.rake'
    end
  end  
end
#:nocov:
