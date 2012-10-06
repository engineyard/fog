require 'fog/cloud_sigma'
require 'fog/compute'
require 'digest/md5'

module Fog
  module Compute
    class CloudSigma < Fog::Service

      requires :cloud_sigma_username, :cloud_sigma_password, :cloud_sigma_region
      request_path 'fog/cloud_sigma/requests/compute'

      model_path 'fog/cloud_sigma/models/compute'
      model :volume
      collection :volumes

      request :get_volume
      request :get_volumes
      request :create_volume

      class Real
        attr_reader :connection, :username, :password

        def initialize(options={})
          @region     = options[:cloud_sigma_region] || "lvs"
          @host       = "turloapi.#{@region}.cloudsigma.com"
          @username   = options[:cloud_sigma_username]
          @password   = options[:cloud_sigma_password]
          @connection = Excon.new("https://#{@host}/2.0/", {:ssl_verify_peer => false})
        end

        def request(params)
          method  = params[:method]  || :get
          expects = params[:expects] || [201, 200]
          path    = params[:path]
          query   = params[:query] || {}
          headers = {
            "Accept"        => "application/json",
            "Authorization" => "Basic #{["#{username}:#{password}"].pack("m*").chomp}",
          }.merge(params[:headers] || {})
          response = @connection.request(method: method, query: query, path: path, expects: expects)
          JSON.parse(response.body)
        end

      end # Real

      class Mock
        def initialize(options={})
          @region  = option[:cloud_sigma_region] || "lvs"
        end

        def self.data
          @data ||= Hash.new{|h,k| h[k]= {
            :volumes => {},
          }
          }
        end

        def self.reset
          @data = nil
        end

        def data
          self.class.data[@region]
        end

        def reset_data
          self.class.data = nil
        end
      end
    end # CloudSigma
  end # Compute
end # Fog
