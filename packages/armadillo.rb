require 'package'

class Armadillo < Package
  description 'Armadillo is a high quality linear algebra library (matrix maths) for the C++ language, aiming towards a good balance between speed and ease of use'
  homepage 'http://arma.sourceforge.net/'
  version '9.600.5'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/arma/armadillo-9.600.5.tar.xz'
  source_sha256 'dd9cd664282f2c3483af194ceedc2fba8559e0d20f8782c640fd6f3ac7cac2bf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-9.600.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-9.600.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-9.600.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/armadillo-9.600.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cabc00c9184da1185c0fcbe834c1447e0e31a9ff34b9c2ede39f7419b95768cc',
     armv7l: 'cabc00c9184da1185c0fcbe834c1447e0e31a9ff34b9c2ede39f7419b95768cc',
       i686: 'cead7ef29533291a9070b8b1cddf6d909c224463e0e984a4d5bf49a208f17590',
     x86_64: '313502ef0f2c9c701c4e5c59d456a6105c8aba4c63bc0a77a829649ffa2e9e78',
  })

  depends_on 'arpack_ng'
  depends_on 'hdf5'
  depends_on 'superlu'

  def self.build
    suffix = ''
    suffix = '64' if ARCH == 'x86_64'
    system 'cmake',
           '-DCMAKE_BUILD_TYPE=Release',
           "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
           "-DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB}",
           "-DARPACK_LIBRARY=#{CREW_LIB_PREFIX}/libarpack#{suffix}.so",
           '.'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
