require 'fog/core/collection'
require 'fog/cloud_sigma/models/compute/volume'

module Fog
  module Compute
    class CloudSigma

      class Volumes < Fog::Collection

        attribute :limit, squash: "meta", alias: "limit"
        attribute :next, squash: "meta", alias: "next"
        attribute :previous, squash: "meta", alias: "previous"
        attribute :offset, squash: "meta", alias: "offset"
        attribute :count, squash: "meta", alias: "total_count"

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
