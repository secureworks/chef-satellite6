require 'chefspec'
require 'chefspec/berkshelf'
%w( https_proxy http_proxy HTTP_PROXY HTTPS_PROXY).map { |x| ENV.delete(x) }

def loadroles(server)
  Dir['spec/fixtures/roles/*.json'].each do |filename|
    role = File.basename(filename, '.json')
    server.create_role(role, JSON.parse(File.read(filename)))
  end
end

def loadenvs(server)
  Dir['spec/fixtures/environments/*.json'].each do |filename|
    env = File.basename(filename, '.json')
    server.create_environment(env, JSON.parse(File.read(filename)))
  end
end

def loadnodes(server)
  Dir['spec/fixtures/nodes/*.json'].sort.each do |f|
    node_data = JSON.parse(IO.read(f), symbolize_names: false)
    server.create_node(node_data['name'], node_data)
  end
end

def loaddbags(server)
  Dir['spec/fixtures/data_bags/*/*.json'].sort.each do |f|
    item_name = File.basename(f).split('.')[0]
    bag_name = File.basename(File.dirname(f))
    bag_data = JSON.parse(IO.read(f))
    server.create_data_bag(bag_name, item_name => bag_data)
  end
end

def loadfixtures(server)
  loadroles(server)
  loadenvs(server)
  loadnodes(server)
  loaddbags(server)
end
