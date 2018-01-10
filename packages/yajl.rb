require 'package'

class Yajl < Package
  description 'A fast streaming JSON parsing library in C.'
  homepage 'http://lloyd.github.io/yajl/'
  version '2.1.0'
  source_url 'https://github.com/lloyd/yajl/archive/2.1.0.tar.gz'
  source_sha256 '3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
      system "make"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
