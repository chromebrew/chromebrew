# Adapted from Arch Linux libavif PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libavif/trunk/PKGBUILD

require 'package'

class Libavif < Package
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  @_ver = '0.9.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/AOMediaCodec/libavif/archive/v#{@_ver}.tar.gz"
  source_sha256 'ea1603fc18e7dd20cf01f0b405156576886ecb5df84db8c0e87187cd2f8a00f4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libavif-0.9.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1f61a3c2509df65e7206ddc4ac79c5e4328f5f369d59da384c3f76fef87aa287',
     armv7l: '1f61a3c2509df65e7206ddc4ac79c5e4328f5f369d59da384c3f76fef87aa287',
       i686: 'd519816e462351cb38c44734dd9ce82fc8ed553614ca40a2683e88c710bd15fd',
     x86_64: '639ba89c4a63d68f714bcf1bb56314594bd5eb5e41ba764424a5e115c97ce6c7'
  })

  depends_on 'libaom'
  depends_on 'dav1d'
  depends_on 'rav1e' unless ARCH == 'i686'
  depends_on 'svt_av1' if ARCH == 'x86_64'
  depends_on 'libpng'
  depends_on 'libjpeg'
  depends_on 'libyuv'
  depends_on 'nasm' => ':build'
  depends_on 'pkgconf' => ':build'
  depends_on 'gdk_pixbuf' => ':build'

  def self.build
    ARCH == 'i686' ? (@rav1e = 'OFF') : (@rav1e = 'ON')
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
        -DAVIF_CODEC_RAV1E=#{@rav1e} \
        -DAVIF_CODEC_SVT=#{@svt} \
        -DAVIF_BUILD_GDK_PIXBUF=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
