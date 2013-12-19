# -*- coding: utf-8 -*-
require 'ya_queen'

module YaQueen
  class Base
    attr_reader :context, :name, :config, :root, :servers
    def initialize(context, name, configs)
      @context = context
      @name = name
      @root = configs
      @config = configs[name.to_sym] || configs[name.to_s]
      @servers = @config["servers"] || {}
      if s = @config["server"]
        @servers[s] = {}
      end
    end

    def method_missing(name, *args, &block)
      if context.respond_to?(name)
        context.send(name, *args, &block)
      else
        begin
          context.send(name, *args, &block)
        rescue NameError
          super
        end
      end
    end

    def define_tasks
      return if servers.nil? or servers.empty?

      t = self
      task(:"@#{name}"){ t.define_role_task }

      servers.each do |host, options|
        after :"@#{name}", :"@#{name}/#{host}"
        task( :"@#{name}/#{host}"){ t.define_each_task(host, options) }
        after :"@#{name}/#{host}", :"@#{name}/common"
      end
      task(:"@#{name}/common") do
        t.define_common_task
        t.set_deploy_target("@#{name}")
      end
    end

    def role_task(&block)  ; @role_task   = block; end
    def common_task(&block); @common_task = block; end
    def each_task(&block)  ; @each_task   = block; end

    def define_role_task  ; @role_task.call if @role_task; end
    def define_common_task; @common_task.call if @common_task; end
    def define_each_task(host, options); @each_task.call(host, options) if @each_task; end

    ## デプロイ先サーバ・ディレクトリ選択時に異なる種類のデプロイ対象を選択できないようにする
    ## (cap vagrant @apisrv-a01 @gotool01 deploy:update などをできないようにする)
    def set_deploy_target(tgt)
      case selected = context.fetch(:selected_deploy_target, nil)
      when nil
        context.set :selected_deploy_target, tgt
      when tgt
        # OK, do nothing
      else
        raise "already selected deploy target: #{selected}"
      end
    end
  end

end
