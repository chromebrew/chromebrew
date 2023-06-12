require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  @_ver = '23.05.0'
  version @_ver
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://poppler.freedesktop.org/poppler-#{@_ver}.tar.xz"
  source_sha256 '38294de7149ebe458191a6e6d0e2837da7dba8683900a635252f6d0ee235f990'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/23.05.0_armv7l/poppler-23.05.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/23.05.0_armv7l/poppler-23.05.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler/23.05.0_x86_64/poppler-23.05.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e036c8ab72742d3b930556dbe38c8e1ac13a5949dc2921501e5e817ad846661e',
     armv7l: 'e036c8ab72742d3b930556dbe38c8e1ac13a5949dc2921501e5e817ad846661e',
     x86_64: '31038120feb7c27da4dd97cfdb5cf7babe89e94030d0c5d2ba6ec2cef85f17ef'
  })

  depends_on 'boost' => :build
  depends_on 'cairo' => :build
  depends_on 'curl' # R
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'lcms' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'nspr' => :build
  depends_on 'nss' # R
  depends_on 'openjpeg' # R
  depends_on 'poppler_data' => :build
  depends_on 'qtbase' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DENABLE_UNSTABLE_API_ABI_HEADERS=ON \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
