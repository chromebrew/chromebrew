require 'package'

class Llvm_unwind < Package
  description 'Part of the LLVM project.'
  homepage 'https://github.com/llvm-mirror/libunwind'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/libunwind-5.0.1.src.tar.xz'
  source_sha256 '6bbfbf6679435b858bd74bdf080386d084a76dfbf233fb6e47b2c28e0872d0fe'

  depends_on 'cmake' => :build
  depends_on 'llvm'

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
