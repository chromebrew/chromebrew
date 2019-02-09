require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.63.0'
  source_url 'https://poppler.freedesktop.org/poppler-0.63.0.tar.xz'
  source_sha256 '27cc8addafc791e1a26ce6acc2b490926ea73a4f89196dd8a7742cff7cf8a111'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.63.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.63.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.63.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-0.63.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '327284b83bcd2b5ab97ba2d471fd25bbc7da95704f1d766bb85c56232b2d84df',
     armv7l: '327284b83bcd2b5ab97ba2d471fd25bbc7da95704f1d766bb85c56232b2d84df',
       i686: '06c135358dcdef45c53460c0724b8a565348e4ccc5053ad29eb605b6bc1ff31d',
     x86_64: 'e32bb8caf1dfea59b8c295d0e0c02c60e2917b18f1c667a1765d5cebb62a59be',
  })

  depends_on 'cairo'
  depends_on 'harfbuzz'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'openjpeg'

  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      system "cmake",
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
