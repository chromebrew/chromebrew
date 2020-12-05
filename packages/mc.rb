require 'package'

class Mc < Package
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.25'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc/archive/4.8.25.tar.gz'
  source_sha256 '8a4aa1556a528fbe9140c47aa3d0665155187468a17c3b80a824de5fcbbebae1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.25-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.25-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mc-4.8.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b2e335ad9f3fff1ee7f64f79c3bc0b4b15fd51a6974fa6f11254a99683b887d',
     armv7l: '5b2e335ad9f3fff1ee7f64f79c3bc0b4b15fd51a6974fa6f11254a99683b887d',
       i686: 'be1e4b7953d540ef610db499db67c55354889c4d305ca96a9dd2a7b90300f3d9',
     x86_64: 'be58cc2c96f8cc3c5caddaab9488aa727cc48353e11f9784e7535852886c066c',
  })

  depends_on 'glib' => :build
  depends_on 'aspell'

  ENV['LIBS'] = '-ldl -lssl -lcrypto'
  def self.build
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
