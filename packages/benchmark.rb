require 'package'

class Benchmark < Package
  description 'A microbenchmark support library from Google'
  homepage 'https://github.com/google/benchmark/'
  @_ver = '1.5.5'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/benchmark.git'
  git_hashtag 'v' + @_ver

  extra_url 'https://github.com/google/googletest.git' => 'release-1.11.0'
  extra_url 'https://raw.githubusercontent.com/skycocker/chromebrew/master/install.sh' => '47b36145a617b2a7e2222184cfa92ebb1c13bba4787c1efd7a0a85d54c211632'

  def self.build
    Dir.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} \
              -DBENCHMARK_USE_LIBCXX=OFF \
              -DBENCHMARK_ENABLE_ASSEMBLY_TESTS=OFF \
              -DBENCHMARK_ENABLE_GTEST_TESTS=ON \
              -DBENCHMARK_ENABLE_TESTING=ON \
              -DINSTALL_GTEST=OFF .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
