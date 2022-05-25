require 'package'

class Benchmark < Package
  description 'A microbenchmark support library from Google'
  homepage 'https://github.com/google/benchmark/'
  version '1.5.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/benchmark/archive/v1.5.2.tar.gz'
  source_sha256 'dccbdab796baa1043f04982147e67bb6e118fe610da2c65f88912d73987e700c'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/benchmark/1.5.2_armv7l/benchmark-1.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/benchmark/1.5.2_armv7l/benchmark-1.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/benchmark/1.5.2_i686/benchmark-1.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/benchmark/1.5.2_x86_64/benchmark-1.5.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9aa663f4068a79d821bc556f6dc60b0e6ee2278505cd747e94a0fd7750258711',
     armv7l: '9aa663f4068a79d821bc556f6dc60b0e6ee2278505cd747e94a0fd7750258711',
       i686: 'e8f37ed6c926979e2c13949f3cf8eaeb9e7e9eedbc751d550ead9680e0a87a5c',
     x86_64: '71f73a3dc296d91b2a5ed685396cbad25ad69e0d231cbed59a5d44391e98aa31'
  })

  def self.patch
    @limitsh = <<~EOF
      --- a/src/benchmark_register.h
      +++ b/src/benchmark_register.h
      @@ -1,6 +1,7 @@
       #ifndef BENCHMARK_REGISTER_H
       #define BENCHMARK_REGISTER_H

      +#include <limits>
       #include <vector>

       #include "check.h"
    EOF
    File.write('limitsh.patch', @limitsh)
    system 'patch -p 1 -i limitsh.patch'
  end

  def self.prebuild
    system 'git clone git://github.com/google/googletest.git -b release-1.10.0 --depth 1' # Required for build, won't interfere with the gtest package
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} \
              -DBENCHMARK_USE_LIBCXX=OFF \
              -DBENCHMARK_ENABLE_ASSEMBLY_TESTS=OFF \
              -DBENCHMARK_ENABLE_GTEST_TESTS=ON \
              -DBENCHMARK_ENABLE_TESTING=ON \
              -DINSTALL_GTEST=OFF .."
      system 'ninja'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system 'ninja -C builddir test'
  end
end
