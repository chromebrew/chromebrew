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
    aarch64: '670ab03acd4f929fd315e719b1c66c3b56651617449559d28f15b5124522f0e8',
     armv7l: '670ab03acd4f929fd315e719b1c66c3b56651617449559d28f15b5124522f0e8',
       i686: 'ff9c0ee2ffeca603bfc2754b256064168b353d02ed6506eff4008c961ba6b79b',
     x86_64: '21e32bf15e717295c73a39edc33c12894c8d5f8ccc2dd4740b0ab3e265a28355',
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
