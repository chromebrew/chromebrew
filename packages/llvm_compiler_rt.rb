require 'package'

class Llvm_compiler_rt < Package
  description 'Part of the LLVM project.'
  homepage 'https://compiler-rt.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/compiler-rt-5.0.1.src.tar.xz'
  source_sha256 '4edd1417f457a9b3f0eb88082530490edf3cf6a7335cdce8ecbc5d3e16a895da'

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
