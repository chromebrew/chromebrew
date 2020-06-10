require 'package'

class Aspell < Package
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.8'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/aspell/aspell-0.60.8.tar.gz'
  source_sha256 'f9b77e515334a751b2e60daab5db23499e26c9209f5e7b7443b05235ad0226f2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ec931f1b5a7f23a2eef005a698b2fcda44bcbfe6c9d7c7e3fcc3df91bb284f62',
     armv7l: 'ec931f1b5a7f23a2eef005a698b2fcda44bcbfe6c9d7c7e3fcc3df91bb284f62',
       i686: '9ab3ed9b17c48be746b1d6d594126259ce38f13b162642b49fd37e73e3462f65',
     x86_64: '43dfba23530b07ab4e59c3fe554904d4316646914a77a802009cfef55a01ff34',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
