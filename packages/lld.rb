require 'package'

class Lld < Package
  description 'LLD is a linker from the LLVM project.'
  homepage 'https://lld.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/lld-5.0.1.src.tar.xz'
  source_sha256 'd5b36c0005824f07ab093616bdff247f3da817cae2c51371e1d1473af717d895'

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
