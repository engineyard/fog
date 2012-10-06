module Fog
  module Compute
    class CloudSigma
      class Real

        def get_volumes(options={})
          params = {
            :method => :get,
            :path   => "/2.0/drives/",
          }

          request(params)
        end
      end
    end
  end
end
