require 'package'

class Ldc < Package                 # The first character of the class name must be upper case
  description 'D language compiler using LLVM.'
  homepage 'https://github.com/ldc-developers/ldc'
  version '1.7.0'
  source_url 'https://github.com/ldc-developers/ldc/releases/download/v1.7.0/ldc-1.7.0-src.tar.gz'
  source_sha256 '7cd46140ca3e4ca0d52c352e5b694d4d5336898ed4f02c3e18e0eafd69dd18bd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'llvm'
  depends_on 'curl'
  depends_on 'gcc'
  depends_on 'ncurses'
  depends_on 'zlibpkg'
  depends_on 'libconfig' => :build
  depends_on 'cmake' => :build
  depends_on 'libedit' => :build

  def self.build                   # the steps required to build the package
    system "mkdir", "build"
    system "curl -L https://github.com/ldc-developers/ldc/releases/download/v0.17.5/{ldc-0.17.5-src.tar.gz} -o \"#1\""
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('ldc-0.17.5-src.tar.gz') ) == '7aa540a135f9fa1ee9722cad73100a8f3600a07f9a11d199d8be68887cc90008'
    system "tar xzf ldc-0.17.5-src.tar.gz -C build"
    system "cmake", "-Bbuild/ldc-0.17.5-src", "-Hbuild/ldc-0.17.5-src"
    system "make", "-C", "build/ldc-0.17.5-src", "-j#{CREW_NPROC}" 
    system "cmake", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_SKIP_RPATH=ON", "-DBUILD_SHARED_LIBS=BOTH",
                    "-DLDC_WITH_LLD=OFF", "-DD_COMPILER=build/ldc-0.17.5-src/bin/ldmd2",
                    "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}", "-Bbuild", "-H."
    system "make", "-C", "build", "-j#{CREW_NPROC}"
  end

  def self.install                 # the steps required to install the package
    system "make", "-C", "build", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
