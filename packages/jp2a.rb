require 'buildsystems/autotools'

class Jp2a < Autotools
  description 'jp2a is a simple JPEG/PNG to ASCII converter.'
  homepage 'https://github.com/Talinx/jp2a'
  version '1.1.1-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Talinx/jp2a/releases/download/v1.1.1/jp2a-1.1.1.tar.bz2'
  source_sha256 '3b91f26f79eca4e963b1b1ae2473722a706bf642218f20bfe4ade5333aebb106'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1-1_armv7l/jp2a-1.1.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1-1_armv7l/jp2a-1.1.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1-1_i686/jp2a-1.1.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jp2a/1.1.1-1_x86_64/jp2a-1.1.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9438a0ebd55061bcb22278bc446bd5b43923afd4bacd0850193dfd5f1886c702',
     armv7l: '9438a0ebd55061bcb22278bc446bd5b43923afd4bacd0850193dfd5f1886c702',
       i686: 'd577997a33292f4859a6609421b04834a5ec66cf5dd4dcb2977a0a593a954ca8',
     x86_64: '43d23d90642210eee4eca270d1760af66320485d1309bb717391d400e3223015'
  })

  depends_on 'curl' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'ncurses' # R
  depends_on 'termcap' # R

  pre_configure_options "CFLAGS='-lncurses -ltinfo -I#{CREW_PREFIX}/include/ncurses #{CREW_ENV_OPTIONS_HASH['CFLAGS']}' LDFLAGS='-L#{CREW_LIB_PREFIX} -lncurses -ltinfo #{CREW_ENV_OPTIONS_HASH['LDFLAGS']}'"
  configure_options '--enable-curl'

  def self.check
    system 'make check || true'
  end
end
