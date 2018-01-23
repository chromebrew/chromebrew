require 'package'

class Llvm < Package
  description 'The LLVM Project is a collection of modular and reusable compiler and toolchain technologies.'
  homepage 'https://llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/llvm-5.0.1.src.tar.xz'
  source_sha256 '5fa7489fc0225b11821cab0362f5813a05f2bcf2533e8a4ea9c9c860168807b0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb7b3dd68b77003dd23855c9b561688add6c1ed4bf594cbcbb34dc810864099a',
     armv7l: 'cb7b3dd68b77003dd23855c9b561688add6c1ed4bf594cbcbb34dc810864099a',
       i686: '70391e63dfb43c3f7a9a19458317f594c548d69385fb3f4970cafbb3faa02058',
     x86_64: '29a7a6cac33ff376a57fd4ac36cc50690255d6a8b2e2f46b7f0818bf942a9927',
  })

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
