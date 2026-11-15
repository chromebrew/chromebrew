require 'buildsystems/meson'

class Libdisplay_info < Meson
  description 'EDID and DisplayID library'
  homepage 'https://emersion.pages.freedesktop.org/libdisplay-info/'
  version '0.4.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/emersion/libdisplay-info.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a302d7c134c91933e52f5f09d63c6b3bfa9c06a959938c62f49699446f9ac468',
     armv7l: 'a302d7c134c91933e52f5f09d63c6b3bfa9c06a959938c62f49699446f9ac468',
     x86_64: '3094999034071c41edb85a643bdf3d4d9ff89a0bd2655d95b91d33ad36b57743'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'hwdata' => :library
  depends_on 'libx11' => :library
  depends_on 'v4l_utils' => :library
end
