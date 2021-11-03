require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.22-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.22.tar.gz'
  source_sha256 'c3342d42e67139c165b8b128d033b5c96893a13ac5f25933190315214e87a948'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-1_armv7l/lzip-1.22-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-1_armv7l/lzip-1.22-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22_i686/lzip-1.22-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22-1_x86_64/lzip-1.22-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9fcf5bbc487dc8196ce9d272a2f86b6f12ef122f4b7610f4b1570f3fadb51ef8',
     armv7l: '9fcf5bbc487dc8196ce9d272a2f86b6f12ef122f4b7610f4b1570f3fadb51ef8',
       i686: 'cb4110131bdd571ae4ef73c32548e53a792f833da399597a29e89daea454e29a',
     x86_64: '670598329208beb7244a6d9a58c67bc5dd74c3ee81aedaa93749d5696456c19e',
  })

  depends_on 'musl_native_toolchain' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              CXX=#{CREW_PREFIX}/musl/bin/g++ \
              CXXFLAGS='#{CREW_COMMON_FLAGS} -static'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
