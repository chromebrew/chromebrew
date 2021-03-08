require 'package'

class Libvips < Package
  description 'A fast image processing library with low memory needs'
  homepage 'https://libvips.github.io/libvips/'
  @_ver = '8.10.6-beta'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libvips/libvips/archive/v#{@_ver}.tar.gz"
  source_sha256 '975371c3650dbfedbde012b6573034338b0bb8f03d5df8d031abb80c3b4c9014'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvips-8.10.6-beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvips-8.10.6-beta-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvips-8.10.6-beta-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvips-8.10.6-beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '64f9cad9ad9287b1c57086adec379640676a4a456b3e753d9e7797fe0ee92ec7',
     armv7l: '64f9cad9ad9287b1c57086adec379640676a4a456b3e753d9e7797fe0ee92ec7',
       i686: '504779b4a009c269dc19dc4f3bb0ad60512dc53da38bfbba3507c959540e3d37',
     x86_64: '3d719741999b3e75ab54788b99d0468217b539ec9e79d1f672a71f14002a6c96'
  })

  depends_on 'cfitsio'
  depends_on 'fftw'
  depends_on 'imagemagick'
  depends_on 'libexif'
  depends_on 'libgsf'
  depends_on 'libheif'
  depends_on 'libimagequant'
  depends_on 'librsvg'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
