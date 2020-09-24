require 'package'

class Eigen < Package
  description 'Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms.'
  homepage 'http://eigen.tuxfamily.org/'
  version '3.3.7'
  compatibility 'all'
  source_url 'https://gitlab.com/libeigen/eigen/-/archive/3.3.7/eigen-3.3.7.tar.bz2'
  source_sha256 '685adf14bd8e9c015b78097c1dc22f2f01343756f196acdc76a678e1ae352e11'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/eigen-3.3.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/eigen-3.3.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/eigen-3.3.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/eigen-3.3.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd5cf4005c822890e8d6a3a57fd186151dfd36d0fef513200a2e81fa767ddb64e',
     armv7l: 'd5cf4005c822890e8d6a3a57fd186151dfd36d0fef513200a2e81fa767ddb64e',
       i686: '11f717b454e479d2f91ad0410aa403fa68c904fab37a8f30499254f3e780964a',
     x86_64: '4ae4ecb6aed2407f0e4adf84116b91b40e830eaed6d2ef028825a26e89d8bc72',
  })

  depends_on 'boost'
  depends_on 'fftw'
  depends_on 'mesa'
  depends_on 'superlu'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
