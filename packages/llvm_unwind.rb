require 'package'

class Llvm_unwind < Package
  description 'Part of the LLVM project.'
  homepage 'https://github.com/llvm-mirror/libunwind'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/libunwind-5.0.1.src.tar.xz'
  source_sha256 '6bbfbf6679435b858bd74bdf080386d084a76dfbf233fb6e47b2c28e0872d0fe'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_unwind-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dd596b74f6f89efdb9fe51bb9fe17d7064a5accdef2da3286582d0691bacdb65',
     armv7l: 'dd596b74f6f89efdb9fe51bb9fe17d7064a5accdef2da3286582d0691bacdb65',
       i686: '23a64c1640463bb040872db622859d18d6d4615f48a95826d6a01c899127780a',
     x86_64: 'fafe29e0aad24c862795790eb13508599a9ef1ea9691d2b576780c0d84dd98ba',
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
