module PartialCompiler
  require 'partial_compiler/railtie' if defined?(Rails)
  @config = {
    template_engine: "ERB",
    original_extension: "html.erb",
    rendering_engine_partial_format: "= render partial:",
    # This code would be the code that's executing inside your template, e.g. `render partial: 'my_partial'`
    regex_partial_eval_match: /(render .*)%>/,
    run_compiled: !Rails.env.development? 
  }

  @valid_config_keys = @config.keys

  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  def self.config
    @config
  end
end

require "partial_compiler/plugin"
require "partial_compiler/file_copier"
require "partial_compiler/partial_reader"
require "partial_compiler/compiler"
