require "ya_queen/version"

module YaQueen
  autoload :Config, "ya_queen/config"
  autoload :Base, "ya_queen/base"

  class << self
    def configure(context, path)
      config = self.new(context, path)
      yield(config) if block_given?
      config
    end
  end

end
