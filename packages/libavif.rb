require 'package'

class Libavif < Package
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  @_ver = '0.9.0'
  version "#{@_ver}-1"
  license 'BSD-2'
  compatibility 'all'
  source_url "https://github.com/AOMediaCodec/libavif/archive/v#{@_ver}.tar.gz"
  source_sha256 'ea1603fc18e7dd20cf01f0b405156576886ecb5df84db8c0e87187cd2f8a00f4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a8da55cfc5b76744c0925508e0824f861a6846d87960ebefbfdcf09c4d36a9c9',
     armv7l: 'a8da55cfc5b76744c0925508e0824f861a6846d87960ebefbfdcf09c4d36a9c9',
       i686: '2b0ff587fc88d91ea8142d6eec6e5aba0c00a6ca0a9c63d83551c66c97a44e36',
     x86_64: 'd35b961e2c797c54aedbf2e7addac2c0f8e8a1419d51d85fd62c27c66fd53975'
  })

  depends_on 'libaom'
  depends_on 'dav1d'
  depends_on 'rav1e'
  depends_on 'svt_av1' if ARCH == 'x86_64'
  depends_on 'libpng'
  depends_on 'libjpeg'
  depends_on 'libyuv'
  depends_on 'nasm' => ':build'
  depends_on 'pkgconf' => ':build'
  depends_on 'gdk_pixbuf' => ':build'

  def self.build
    ARCH == 'x86_64' ? (@svt = 'ON') : (@svt = 'OFF')

    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DAVIF_BUILD_APPS=ON \
        -DAVIF_CODEC_AOM=ON \
        -DAVIF_CODEC_DAV1D=ON \
        -DAVIF_CODEC_RAV1E=ON \
        -DAVIF_CODEC_SVT=#{@svt} \
        -DAVIF_BUILD_GDK_PIXBUF=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system 'gdk-pixbuf-query-loaders --update-cache'
  end
end
