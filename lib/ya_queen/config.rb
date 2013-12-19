require 'ya_queen'

module YaQueen
  class Config
    def initialize(context, path)
      @configs = YAML.load_file(path)
      @context = context
    end

    def define_server_tasks(name, options = {})
      config = @configs[name]
      klass = options[:class] || Base
      t = klass.new(@context, name, @configs)
      yield(t, config) if block_given?
      t.define_tasks
    end
  end

end
