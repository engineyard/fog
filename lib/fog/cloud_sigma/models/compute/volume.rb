module Fog
  module Compute
    class CloudSigma
      class Volume < Fog::Model
        #"affinities": [],
        #"media": "disk",
        #"name": "Ubuntu Oneiric 64bit",
        #"owner": "testuser@cloudsigma.com",
        #"resource_uri": "/2.0/drives/2adee418-74c4-409f-a0a4-5c4ff1662e62/",
        #"size": 40216654,
        #"status": "mounted",
        #"uuid": "2adee418-74c4-409f-a0a4-5c4ff1662e62"
        identity  :id, :aliases => 'uuid'

        attribute :name
        attribute :media
        attribute :affinities, type: :array
        attribute :owner
        attribute :size, type: :integer
        attribute :created
        attribute :status
        attribute :resource_uri

        attr_accessor :encryption

        def save
          if new_record?
            requires :name, :size, :media, :encryption

            params = {
              "name" => self.name,
              "size" => self.size,
              "media" => self.media,
              "encryption" => self.encryption,
            }

            connection.create_volume(params)
          else
            requires :identity

            params = {
              "name" => self.name,
              "size" => self.size,
              "media" => self.media,
            }

            connection.update_volume(params)
          end
        end

      end # Volume
    end # Cloudstack
  end # Compute
end # Fog
