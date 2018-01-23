require 'package'

class Clang_libcpp < Package
  description 'Standard library for Clang5.'
  homepage 'https://libcxx.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/libcxx-5.0.1.src.tar.xz'
  source_sha256 'fa8f99dd2bde109daa3276d529851a3bce5718d46ce1c5d0806f46caa3e57c00'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clang_libcpp-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clang_libcpp-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clang_libcpp-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clang_libcpp-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0e133108ae8098f5b4f7f7d8bade54e7ff3fabf237f5abcf43129b36051d4cff',
     armv7l: '0e133108ae8098f5b4f7f7d8bade54e7ff3fabf237f5abcf43129b36051d4cff',
       i686: '7d05985319135a390385059ddc4ef7067398518fa8daaf6a672a68a3f5a08433',
     x86_64: '3a3d97ee96bb2705e98bbac73905717e5ea257acc7ee20745f0644c7dc720eaa',
  })

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
