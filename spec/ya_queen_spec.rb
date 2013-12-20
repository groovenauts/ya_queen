require 'spec_helper'

require 'yaml'

describe YaQueen do
  it 'should have a version number' do
    YaQueen::VERSION.should_not be_nil
  end

  it 'should build tasks' do
    context = mock(:context)
    expect(context).to receive(:task).with(:"@api_server")

    %w[api_server01 api_server02].each do |host|
      expect(context).to receive(:after).with(:"@api_server", :"@api_server/#{host}")
      expect(context).to receive(:task).with(:"@api_server/#{host}")
      expect(context).to receive(:after).with(:"@api_server/#{host}", :"@api_server/common")
    end

    expect(context).to receive(:task).with(:"@api_server/common")

    YaQueen.configure(context, File.expand_path("../test01.yml", __FILE__)) do |c|
      c.define_server_tasks(:api_server)
    end
  end
end
