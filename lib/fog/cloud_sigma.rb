require 'fog/core'

module Fog
  module CloudSigma

    extend Fog::Provider

    service(:compute, 'cloud_sigma/compute', 'Compute')

  end
end
