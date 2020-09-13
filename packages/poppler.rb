require 'package'

class Poppler < Package
  description 'Poppler is a PDF rendering library based on the xpdf-3.0 code base.'
  homepage 'https://poppler.freedesktop.org/'
  version '20.08.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://poppler.freedesktop.org/poppler-20.08.0.tar.xz'
  source_sha256 'ae65fef04bbf63259a6352e7b620719115d4fb97f5079b0b8b00a8eb0c86eca5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-20.08.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-20.08.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler-20.08.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'defc7c9fc0961e514c9c78c838e2acbf627b613ec3d0b1c0b16e7ffb9f55c04d',
     armv7l: 'defc7c9fc0961e514c9c78c838e2acbf627b613ec3d0b1c0b16e7ffb9f55c04d',
     x86_64: '69e2e8d06d22a11684aeb2a43980e75a4e9fccee29fc53961ca7a990ca218ce9',
  })

  depends_on 'boost'
  depends_on 'cairo'
  depends_on 'curl'
  depends_on 'freeglut'
  depends_on 'harfbuzz'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'openjpeg'
  depends_on 'poppler_data'
  depends_on 'qttools'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system 'cmake',
             "-DCMAKE_CXX_FLAGS='-std=c++11 -I#{CREW_PREFIX}/include/GL -I#{CREW_PREFIX}/include/openjpeg-2.3 -I#{CREW_PREFIX}/include'",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DCMAKE_BUILD_TYPE=Release',
             '-DENABLE_UNSTABLE_API_ABI_HEADERS=on',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
