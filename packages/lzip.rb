require 'package'

class Lzip < Package
  description 'Lzip is a lossless data compressor with a user interface similar to the one of gzip or bzip2.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.22'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzip-1.22.tar.gz'
  source_sha256 'c3342d42e67139c165b8b128d033b5c96893a13ac5f25933190315214e87a948'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22_armv7l/lzip-1.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22_armv7l/lzip-1.22-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22_i686/lzip-1.22-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lzip/1.22_x86_64/lzip-1.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34905a03071ba31b215c5aa5f769d2d835063cc3959df47dfdbd38654c1785a0',
     armv7l: '34905a03071ba31b215c5aa5f769d2d835063cc3959df47dfdbd38654c1785a0',
       i686: 'cb4110131bdd571ae4ef73c32548e53a792f833da399597a29e89daea454e29a',
     x86_64: '77c7eb34fe9a72694f1c9fe10f8c27e3205526f90b7bd55c6e659dd34e7b60f8',
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
