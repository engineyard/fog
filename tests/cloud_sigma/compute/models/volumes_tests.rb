
def volumes_tests(connection, params = {}, mocks_implemented = true)

  collection_tests(connection.volumes, params, mocks_implemented) do

    if !Fog.mocking? || mocks_implemented
      @instance.wait_for { ready? }
    end

  end

end

config = compute_providers[:cloud_sigma]

Shindo.tests("Fog::Compute[:cloud_sigma] | volumes", ["cloud_sigma"]) do
  volumes_tests(Fog::Compute[:cloud_sigma], config[:volume_attributes], config[:mocked])
end
