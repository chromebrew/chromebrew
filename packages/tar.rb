require 'buildsystems/autotools'

class Tar < Autotools
  description 'GNU Tar provides the ability to create tar archives, as well as various other kinds of manipulation.'
  homepage 'https://www.gnu.org/software/tar/'
  version '1.35'
  license 'BSD'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/tar/tar-1.35.tar.xz'
  source_sha256 '4d62ff37342ec7aed748535323930c7cf94acf71c3591882b26a7ea50f3edc16'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.35_armv7l/tar-1.35-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.35_armv7l/tar-1.35-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.35_i686/tar-1.35-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tar/1.35_x86_64/tar-1.35-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2c9d3d099f95858ea9eefc15efdf082b1a60f891f1eaeab96973d448caf34351',
     armv7l: '2c9d3d099f95858ea9eefc15efdf082b1a60f891f1eaeab96973d448caf34351',
       i686: '52018d0418db20f3d38bfcd200f01e1c0081d9abcd6f1b21b3edd47672247b2a',
     x86_64: '860624ccd43ece3195914c147943241ccad087a9eefb44ddc32e4120454a871e'
  })

  depends_on 'acl' # R
  depends_on 'glibc' # R

  configure_options '--disable-year2038' unless ARCH == 'x86_64'
end
