connection = Fog::Compute::RackspaceV2.new
flavor     = Fog.credentials[:rackspace_flavor_id] || connection.flavors.first
image      = Fog.credentials[:rackspace_image_id]  || connection.images.first

Shindo.tests('Fog::Compute::RackspaceV2 | servers', ['rackspace']) do
  options = {
    :name => "fog_server_#{Time.now.to_i.to_s}",
    :flavor_id => flavor.id,
    :image_id => image.id
  }
  collection_tests(connection.servers, options, true) do
    @instance.wait_for { ready? }
  end

  tests("#bootstrap").succeeds do
    pending if Fog.mocking?
    @server = connection.servers.bootstrap(options)
  end

  if @server
    @server.destroy
  end

end
