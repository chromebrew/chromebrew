require 'package'

class Leptonica < Package
  description 'Software that is broadly useful for image processing and image analysis applications'
  homepage 'http://www.leptonica.com/'
  @_ver = '1.82.0'
  version "#{@_ver}-1"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/DanBloomberg/leptonica.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0-1_armv7l/leptonica-1.82.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0-1_armv7l/leptonica-1.82.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0-1_i686/leptonica-1.82.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/leptonica/1.82.0-1_x86_64/leptonica-1.82.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1860d784a88c153650ab389c339dafa608e350a9790dd2e30e52f1c8b5654115',
     armv7l: '1860d784a88c153650ab389c339dafa608e350a9790dd2e30e52f1c8b5654115',
       i686: '52e64b338abe4cdae009176a7f55ddb5602cc05ef2c130eb6930708f9302aedc',
     x86_64: '5ef3ed7eb5760e110eb58faeb678aa6bfd549b344d91efb7b7e185deb7410acd'
  })

  depends_on 'giflib'
  depends_on 'libjpeg'
  depends_on 'harfbuzz'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'openjpeg'
  depends_on 'glibc' # R
  depends_on 'libdeflate' # R
  depends_on 'libpng' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system '[ -x configure ] || ./autogen.sh'
    system "[ -f Makefile ] || ./configure #{CREW_OPTIONS}"
    system 'mold -run make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
