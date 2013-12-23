# -*- coding: utf-8 -*-
require 'ya_queen'

module YaQueen
  class Custom < Base
    def implement_common_task
      skip_keys = %w[roles deploy_to]
      symbol_value_keys = %w[scm deploy_via]
      config.each do |key, value|
        next if key == "roles"
        if value
          value = symbol_value_keys.include?(key.to_s) ? value.to_sym : value
          set key.to_sym, value
        end
      end
      set :deploy_to, fetch(:override_deploy_to, config['deploy_to'])

      super
    end

    def implement_each_task(host, options)
      config['roles'].each do |r|
        role r.to_sym, host
      end
      super
    end
    
  end
end
