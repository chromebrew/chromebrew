require 'buildsystems/autotools'

class Libfs < Autotools
  description 'X.org library interface to the X Font Server.'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libfs'
  license 'MIT'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libfs.git'
  git_hashtag "libFS-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f4159d023ced6bd8b42c5e398ce1a7876de0901077945e8dcdc0b8da1a15789',
     armv7l: '7f4159d023ced6bd8b42c5e398ce1a7876de0901077945e8dcdc0b8da1a15789',
       i686: 'af677f44f3b43f0a4e34ff2c5a45fd28738e9147d1208e8820d219530a33dab1',
     x86_64: '806e70356efb784e7e8be0c8ff0de277619c611a8ea2c76a11a74d7a53439d1c'
  })

  depends_on 'xorg_proto'
  depends_on 'libxtrans'
  depends_on 'glibc' # R
end
