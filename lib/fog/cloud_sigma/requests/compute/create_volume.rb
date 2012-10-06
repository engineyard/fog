module Fog
  module Compute
    class CloudSigma
      class Real

        def create_volume(options)
          params = {
            :method => :post,
            :path   => "/drives",
          }.merge(options)

          request(params)
        end
      end
    end
  end
end
