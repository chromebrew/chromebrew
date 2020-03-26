require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.86.1'
  source_url 'https://poppler.freedesktop.org/poppler-0.86.1.tar.xz'
  source_sha256 'af630a277c8e194c31339c5446241834aed6ed3d4b4dc7080311e51c66257f6c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'automake' => :build
  depends_on 'cairo'
  depends_on 'harfbuzz'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'openjpeg'
  depends_on 'zlibpkg'
  depends_on 'cmake' => :build

  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      system "cmake",
        "-DCMAKE_CXX_FLAGS='-I#{CREW_PREFIX}/include/openjpeg-2.3 -I#{CREW_PREFIX}/include'",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DENABLE_XPDF_HEADERS=ON",
             ".."
      system "make"
    end
  end

  def self.install
    Dir.chdir("builddir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
