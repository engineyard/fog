service = Fog::Compute::RackspaceV2.new
flavor  = Fog.credentials[:rackspace_flavor_id] || service.flavors.first
image   = Fog.credentials[:rackspace_image_id]  || service.images.first

Shindo.tests('Fog::Compute::RackspaceV2 | server', ['rackspace']) do

  options = {
    :name => "fog_server_#{Time.now.to_i.to_s}",
    :flavor_id => flavor.id,
    :image_id => image.id
  }

  model_tests(service.servers, options, true) do
    @instance.wait_for { ready? }
    tests('#reboot("SOFT")').succeeds do
      @instance.reboot('SOFT')
      returns('REBOOT') { @instance.state }
    end

    @instance.wait_for { ready? }
    tests('#reboot("HARD")').succeeds do
      @instance.reboot('HARD')
      returns('HARD_REBOOT') { @instance.state }
    end

    @instance.wait_for { ready? }
    tests('#rebuild').succeeds do
      @instance.rebuild('5cebb13a-f783-4f8c-8058-c4182c724ccd')
      returns('REBUILD') { @instance.state }
    end

    @instance.wait_for { ready? }
    tests('#resize').succeeds do
      @instance.resize(3)
      returns('RESIZE') { @instance.state }
    end

    @instance.wait_for { state == 'VERIFY_RESIZE' }
    tests('#confirm_resize').succeeds do
      @instance.confirm_resize
    end

    @instance.wait_for { ready? }
    tests('#resize').succeeds do
      @instance.resize(2)
      returns('RESIZE') { @instance.state }
    end

    @instance.wait_for { state == 'VERIFY_RESIZE' }
    tests('#revert_resize').succeeds do
      @instance.revert_resize
    end

    @instance.wait_for { ready? }
    tests('#change_admin_password').succeeds do
      @instance.change_admin_password('somerandompassword')
      returns('PASSWORD') { @instance.state }
      returns('somerandompassword') { @instance.password }
    end

    @instance.wait_for { ready? }
  end

  # When after testing resize/resize_confirm we get a 409 when we try to resize_revert so I am going to split it into two blocks
  model_tests(service.servers, options, true) do
    @instance.wait_for { ready? }
    tests('#resize').succeeds do
      @instance.resize(4)
      returns('RESIZE') { @instance.state }
    end

    @instance.wait_for { state == 'VERIFY_RESIZE' }
    tests('#revert_resize').succeeds do
      @instance.revert_resize
    end
    @instance.wait_for { ready? }
  end
end
