require 'package'

class Libvisual < Package
  description 'Libvisual is a library that comes between applications and audio visualisation plugins.'
  homepage 'http://libvisual.org/'
  version '0.4.0'
  compatibility 'all'
  source_url 'https://github.com/Libvisual/libvisual/archive/libvisual-0.4.0.tar.gz'
  source_sha256 'c004e88ae55872b19dc651b0e465b1e57c07e75eacb1bff8a43b6ceb75671850'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvisual-0.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvisual-0.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvisual-0.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvisual-0.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0eb131d81f76405c634d8749a5cbd1138b722c9389156d405c1fdb05ee73fab9',
     armv7l: '0eb131d81f76405c634d8749a5cbd1138b722c9389156d405c1fdb05ee73fab9',
       i686: '2733ad1874d2cde91dec31b5da128847c5d571d56e3c7bf86a91631b06511e26',
     x86_64: 'e3cd0b5b032856552284ec9f278c8d7489087d1722e49bf711b8ea43a2e79724',
  })

  def self.build
    Dir.chdir 'libvisual' do
      system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'libvisual' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
