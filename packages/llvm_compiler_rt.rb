require 'package'

class Llvm_compiler_rt < Package
  description 'Part of the LLVM project.'
  homepage 'https://compiler-rt.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/compiler-rt-5.0.1.src.tar.xz'
  source_sha256 '4edd1417f457a9b3f0eb88082530490edf3cf6a7335cdce8ecbc5d3e16a895da'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/llvm_compiler_rt-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2fcae8af767e99a33d933bef54aa6a4204215eda11429acdf552fc7a02006b07',
     armv7l: '2fcae8af767e99a33d933bef54aa6a4204215eda11429acdf552fc7a02006b07',
       i686: 'fcdff59e1284e2d0ad2c559019d82138a94dfb3036860dc2dfa61fbac455f9fa',
     x86_64: '54feea8df115c8d23c131bb5525de8afe4067149e9ab1423651e2c8040e9726c',
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
