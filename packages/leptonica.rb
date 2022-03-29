require 'package'

class Leptonica < Package
  description 'Software that is broadly useful for image processing and image analysis applications'
  homepage 'http://www.leptonica.com/'
  @_ver = '1.82.0'
  version @_ver.to_s
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/DanBloomberg/leptonica.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0_armv7l/leptonica-1.82.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0_armv7l/leptonica-1.82.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0_i686/leptonica-1.82.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0_x86_64/leptonica-1.82.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e2a96595f055b95b9aa4692ce8e85a0871ecdf61c913bb7c880d6213f3be367f',
     armv7l: 'e2a96595f055b95b9aa4692ce8e85a0871ecdf61c913bb7c880d6213f3be367f',
       i686: 'd87be48dbc0a38bf17449b47683561006df9009087e50a14becdaa68bcef7e59',
     x86_64: 'bd99bd57833ce674b0edd95223df38b7ca65cc1b2d357312f200d771a6d532c1'
  })

  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'harfbuzz'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'openjpeg'

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "[ -f Makefile ] || env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
