require 'package'

class Clang_openmp < Package
  description 'The OpenMP subproject of LLVM contains the components required to build an executable OpenMP program that are outside the compiler itself.'
  homepage 'https://openmp.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/openmp-5.0.1.src.tar.xz'
  source_sha256 'adb635cdd2f9f828351b1e13d892480c657fb12500e69c70e007bddf0fca2653'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clang_openmp-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clang_openmp-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clang_openmp-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clang_openmp-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd9e49ff4e11df413cc68143cf951cd2e8261676ba8fcd8948e2947dc193a952c',
     armv7l: 'd9e49ff4e11df413cc68143cf951cd2e8261676ba8fcd8948e2947dc193a952c',
       i686: 'e462e46e77399edb8d59b11d45b1821ee759e59b289848014479e5fe8dfc7690',
     x86_64: '367eabe360b8bf396c9c733bd7e177ea10c775b8f96d5b14be7a317bb7992f5d',
  })

  depends_on 'cmake' => :build

  def self.build
    Dir.mkdir 'mybuilddir'
    Dir.chdir "mybuilddir" do
      system "cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release .."
      system "cmake --build . --  -j#{CREW_NPROC}"
    end
  end

  def self.install
    Dir.chdir "mybuilddir" do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_PREFIX} -P cmake_install.cmake"
    end
  end
end
