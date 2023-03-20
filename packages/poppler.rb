require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  @_ver = '22.10.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://poppler.freedesktop.org/poppler-#{@_ver}.tar.xz"
  source_sha256 '04e40fad924a6de62e63017a6fd4c04696c1f526dedc2ba5ef275cedf646292a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/22.10.0_armv7l/poppler-22.10.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/22.10.0_armv7l/poppler-22.10.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/22.10.0_i686/poppler-22.10.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/22.10.0_x86_64/poppler-22.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b758ee920b110c2a659f9edb9cc493dc2795e9288e4d96824875814ff060bb61',
     armv7l: 'b758ee920b110c2a659f9edb9cc493dc2795e9288e4d96824875814ff060bb61',
       i686: '894e8803e3f856befe5c4a804c7a5ee337211cb265907389bd8a600f6d49df8b',
     x86_64: '34ba3efee02bdb16f58e848d500b36ae4083f97c30cd6474107db5aa6730ecd0'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'nspr'
  depends_on 'nss'
  depends_on 'openjpeg'
  depends_on 'qtbase'
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'curl' # R
  depends_on 'zlibpkg' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DENABLE_UNSTABLE_API_ABI_HEADERS=on \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
