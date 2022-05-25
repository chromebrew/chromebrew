require 'package'

class Prometheus_cpp < Package
  description 'Prometheus Client Library for Modern C++'
  homepage 'https://github.com/jupp0r/prometheus-cpp/'
  version '0.12.1'
  license 'MIT'
  compatibility 'i686,x86_64'
  source_url 'https://github.com/jupp0r/prometheus-cpp/releases/download/v0.12.1/prometheus-cpp-with-submodules.tar.gz'
  source_sha256 'f116cee772df7bf23fc89fb71c13ad4420601e304a382d77da725da0d0dc4cac'
  binary_compression 'tar.xz'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/prometheus_cpp/0.12.1_i686/prometheus_cpp-0.12.1-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/prometheus_cpp/0.12.1_x86_64/prometheus_cpp-0.12.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: '6fd409af6b2eeaf47267f459feb267f1309cac53b83eeafba27ce5165b5df162',
    x86_64: 'c24ff7e1239a35fa7a34724905226354fc2582585bf3be6f159b2cbb53e03e44'
  })

  depends_on 'zstd'
  depends_on 'civetweb'
  depends_on 'gtest' => :build
  depends_on 'benchmark' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} \
              -DENABLE_PULL=ON \
		          -DENABLE_PUSH=ON \
		          -DENABLE_COMPRESSION=ON \
		          -DENABLE_TESTING=ON \
		          -DBUILD_SHARED_LIBS=ON \
		          -DUSE_THIRDPARTY_LIBRARIES=OFF .."
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
