module Fog
  module Compute
    class CloudSigma
      class Real

        def get_volumes(id)
          options = {
            :method => :get,
            :path   => "/drives/detail",
          }

          request(options)
        end
      end
    end
  end
end
