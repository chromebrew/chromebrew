require 'package'

class Libsigcplusplus < Package
  description 'libsigc++ implements a typesafe callback system for standard C++.'
  homepage 'http://libsigc.sourceforge.net/'
  version '2.99.10'
  source_url 'https://github.com/GNOME/libsigcplusplus/archive/2.99.10.tar.gz'
  source_sha256 '502735363777cd8d540299035daa3f9162912f325491cbb0f8d709b691593e07'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.99.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.99.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.99.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsigcplusplus-2.99.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a8b8bdd9040ebb67bb092055ee36a25135825d08a039f4596e835996bb245cff',
     armv7l: 'a8b8bdd9040ebb67bb092055ee36a25135825d08a039f4596e835996bb245cff',
       i686: '57e89d0057217ae81a55ec675be843ed5dbfa54d5ad1deba4b900c6b9c72c451',
     x86_64: 'da7e1a5edf563ae95c677b89283a2f79cc23380a1b58b264df1abfcfec919bca',
  })

  depends_on 'pkgconfig' => :build
  depends_on 'diffutils' => :build
  depends_on 'm4' => :build
  depends_on 'gcc7' => :build  # c++14 support
  depends_on 'cmake' => :build

  def self.build
    system "mkdir -p build"
    Dir.chdir("build") do
      system "cmake",
             "-DCMAKE_INSTALL_PREFIX:PATH=#{CREW_PREFIX}",
             "-DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX}",
             "-DCMAKE_C_COMPILER=gcc-7.3",
             "-DCMAKE_CXX_COMPILER=g++-7.3",
             "-DCMAKE_CXX_FLAGS=--std=c++14",
             ".."
      system "make"
    end
  end

  def self.install
    Dir.chdir("build") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
