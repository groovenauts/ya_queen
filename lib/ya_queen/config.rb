require 'ya_queen'

module YaQueen
  class Config
    attr_accessor :root_dir

    def initialize(context, path)
      @configs = YAML.load_file(path)
      @context = context
    end

    def define_server_tasks(name, options = {})
      config = @configs[name.to_sym] || @configs[name.to_s]
      config[:root_dir] = self.root_dir
      klass = options[:class] || Base
      t = klass.new(@context, name, @configs)
      yield(t, config) if block_given?
      t.define_tasks
    end
  end

end
