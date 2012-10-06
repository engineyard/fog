module Fog
  module Compute
    class CloudSigma
      class Real

        def create_volume(options)
          params = {
            :method => :post,
            :path   => "/2.0/drives/",
          }.merge(options)

          request(params)
        end
      end
    end
  end
end
