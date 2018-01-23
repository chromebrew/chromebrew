require 'package'

class Clang < Package
  description 'C language family frontend for LLVM.'
  homepage 'https://clang.llvm.org/'
  version '5.0.1'
  source_url 'https://releases.llvm.org/5.0.1/cfe-5.0.1.src.tar.xz'
  source_sha256 '135f6c9b0cd2da1aff2250e065946258eb699777888df39ca5a5b4fe5e23d0ff'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/clang-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/clang-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/clang-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clang-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '10b6e17be70dbb7ffd235f8ba8202365b371928ffe48b36c1e3c4d38ff743e46',
     armv7l: '10b6e17be70dbb7ffd235f8ba8202365b371928ffe48b36c1e3c4d38ff743e46',
       i686: '800cc05762df8508cba1696e26f5f1b38f35c823dc77f5e9bb9eb3fd01902489',
     x86_64: '6512c4905caa1679ab201b31d2e978343f08eb56e0ca5b3006b8aed0c5dbe932',
  })

  depends_on 'cmake' => :build
  depends_on 'llvm'
  depends_on 'clang_libcpp'
  depends_on 'clang_openmp'
  depends_on 'llvm_compiler_rt'
  depends_on 'llvm_polly'
  depends_on 'llvm_unwind'
  depends_on 'lld'

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
      FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
        system "echo '#!/bin/bash' > clangppw"
        system "echo 'GCCVERSION=`gcc --version | grep ^gcc | sed '\\''s/^.* //g'\\''`' >> clangppw"
        system "echo 'TARGET=`gcc -dumpmachine`' >> clangppw"
        system "echo '#{CREW_PREFIX}/bin/clang++ -I#{CREW_PREFIX}/include/c++/v1 -B#{CREW_PREFIX}/lib/gcc/${TARGET}/${GCCVERSION} -lc++ $@' >> clangppw"
        system "chmod 755 clangppw"
        system "echo '#!/bin/bash' > clangw"
        system "echo 'GCCVERSION=`gcc --version | grep ^gcc | sed '\\''s/^.* //g'\\''`' >> clangw"
        system "echo 'TARGET=`gcc -dumpmachine`' >> clangw"
        system "echo '#{CREW_PREFIX}/bin/clang -B#{CREW_PREFIX}/lib/gcc/${TARGET}/${GCCVERSION} $@' >> clangw"
        system "chmod 755 clangw"
      end
    end
  end
end

