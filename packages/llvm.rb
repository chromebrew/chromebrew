require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies.'
  homepage 'https://llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/llvm-5.0.1.src.tar.xz'
  source_sha256 '5fa7489fc0225b11821cab0362f5813a05f2bcf2533e8a4ea9c9c860168807b0'

  depends_on 'cmake' => :build

  def self.build
    Dir.mkdir 'mybuilddir'
    Dir.chdir "mybuilddir" do
      system "cmake .. -DBUILD_SHARED_LIBS=true -DCMAKE_BUILD_TYPE=Release -DLLVM_OPTIMIZED_TABLEGEN=ON"
      system "cmake --build . --  -j#{CREW_NPROC}"
    end
  end

  def self.install
    Dir.chdir "mybuilddir" do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_DEST_PREFIX} -P cmake_install.cmake"
    end
  end
end
