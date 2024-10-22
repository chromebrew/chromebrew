require 'package'
Package.load_package("#{__dir__}/wayland_info.rb")

class Wayland_utils < Package
  description Wayland_info.description
  homepage Wayland_info.homepage
  version Wayland_info.version
  license Wayland_info.license
  compatibility Wayland_info.compatibility

  is_fake

  depends_on 'wayland_info'
end
