require 'package'

class Benchmark < Package
  description 'A microbenchmark support library from Google'
  homepage 'https://github.com/google/benchmark/'
  version '1.5.2'
  compatibility 'all'
  source_url 'https://github.com/google/benchmark/archive/v1.5.2.tar.gz'
  source_sha256 'dccbdab796baa1043f04982147e67bb6e118fe610da2c65f88912d73987e700c'

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
    IO.write("limitsh.patch", @limitsh)
    system 'patch -p 1 -i limitsh.patch'
  end
  
  def self.prebuild
    system "git clone git://github.com/google/googletest.git -b release-1.10.0 --depth 1" # Required for build, won't interfere with the gtest package
  end
    
  def self.build
    Dir.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} \
              -DBENCHMARK_USE_LIBCXX=OFF \
              -DBENCHMARK_ENABLE_ASSEMBLY_TESTS=OFF \
              -DBENCHMARK_ENABLE_GTEST_TESTS=ON \
              -DBENCHMARK_ENABLE_TESTING=ON \
              -DINSTALL_GTEST=OFF .."
      system "ninja"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system "ninja -C builddir test"
  end
end
