require 'package'

class Clang_openmp < Package
  description 'The OpenMP subproject of LLVM contains the components required to build an executable OpenMP program that are outside the compiler itself.'
  homepage 'https://openmp.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/openmp-5.0.1.src.tar.xz'
  source_sha256 'adb635cdd2f9f828351b1e13d892480c657fb12500e69c70e007bddf0fca2653'

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
