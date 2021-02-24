require 'package'

class Prometheus_cpp < Package
  description 'Prometheus Client Library for Modern C++'
  homepage 'https://github.com/jupp0r/prometheus-cpp/'
  version '0.12.1'
  compatibility 'all'
  source_url 'https://github.com/jupp0r/prometheus-cpp/releases/download/v0.12.1/prometheus-cpp-with-submodules.tar.gz'
  source_sha256 'f116cee772df7bf23fc89fb71c13ad4420601e304a382d77da725da0d0dc4cac'

  depends_on 'zstd'
  depends_on 'civetweb'
  depends_on 'gtest' => :build
  depends_on 'benchmark' => :build
  
  def self.build
    Dir.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} \
              -DENABLE_PULL=ON \
		          -DENABLE_PUSH=ON \
		          -DENABLE_COMPRESSION=ON \
		          -DENABLE_TESTING=ON \
		          -DBUILD_SHARED_LIBS=ON \
		          -DUSE_THIRDPARTY_LIBRARIES=OFF .."
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
