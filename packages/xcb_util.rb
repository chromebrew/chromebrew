require 'buildsystems/autotools'

class Xcb_util < Autotools
  description 'The xcb-util package provides additional extensions to the XCB library.'
  homepage 'https://xcb.freedesktop.org/'
  version '0.4.1'
  compatibility 'all'
  license 'MIT-with-advertising'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcb-util.git'
  git_hashtag "xcb-util-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '574ff14c0fd7ab4214cb93487791054d9950e11a7fe4e9011f64205d6d3b7a35',
     armv7l: '574ff14c0fd7ab4214cb93487791054d9950e11a7fe4e9011f64205d6d3b7a35',
       i686: '754596e0d32a87be965993e17fe72d7c7a5691efa7acd51458855e893a1e7773',
     x86_64: '39b73b6cb1c3d345499d1fab0cae2cfc7749df5655cd8bf3de71ed01523969b1'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libxau' # R

end
