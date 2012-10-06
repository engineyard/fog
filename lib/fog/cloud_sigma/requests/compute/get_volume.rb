module Fog
  module Compute
    class CloudSigma
      class Real

        def get_volume(id)
          options = {
            :method => :get,
            :path   => "/2.0/drives/#{id}/",
          }

          request(options)
        end
      end
    end
  end
end
