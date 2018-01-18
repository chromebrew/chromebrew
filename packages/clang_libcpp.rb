require 'package'

class Clang_libcpp < Package
  description 'Standard library for Clang5.'
  homepage 'https://libcxx.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/libcxx-5.0.1.src.tar.xz'
  source_sha256 'fa8f99dd2bde109daa3276d529851a3bce5718d46ce1c5d0806f46caa3e57c00'

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
