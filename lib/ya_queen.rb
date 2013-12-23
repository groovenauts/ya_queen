require "ya_queen/version"

module YaQueen
  autoload :Config, "ya_queen/config"
  autoload :Base  , "ya_queen/base"
  autoload :Custom, "ya_queen/custom"

  class << self
    def configure(context, path)
      config = Config.new(context, path)
      yield(config) if block_given?
      config
    end
  end

end
