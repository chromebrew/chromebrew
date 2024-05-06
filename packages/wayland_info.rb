require 'buildsystems/meson'

class Wayland_info < Meson
  description 'Provides wayland-info, a standalone version of the weston-info utility for displaying information about the Wayland protocols supported by a Wayland compositor.'
  homepage 'https://gitlab.freedesktop.org/wayland/wayland-utils'
  version '1.2.0'
  license 'MIT/Expat'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-utils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3828d0f89df0ddb1de8d38bb2c28fc51d771bed76d202a5b14810565d7ae55f0',
     armv7l: '3828d0f89df0ddb1de8d38bb2c28fc51d771bed76d202a5b14810565d7ae55f0',
       i686: '939c0eaeeec9fcfdf7e54bc1d288ccd3ec23734500c9b2e201039115b00ef3d0',
     x86_64: 'fa833e8a3e633eb6530674fc7a74abe73148f30a98df10991add2b5491c7e9d4'
  })

  depends_on 'glibc' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build
end
