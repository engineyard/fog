require 'fog/core/collection'
require 'fog/cloud_sigma/models/compute/volume'

module Fog
  module Compute
    class CloudSigma

      class Volumes < Fog::Collection

        model Fog::Compute::CloudSigma::Volume

        def all
          data = connection.get_volumes["objects"] || []
          load(data)
        end

        def get(volume_id)
          if volume = connection.get_volume(volume_id)
            new(volume)
          end
        end
      end

    end
  end
end
