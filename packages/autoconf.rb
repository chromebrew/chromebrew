require 'package'

class Autoconf < Package
  description 'Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.'
  homepage 'http://www.gnu.org/software/autoconf/'
  version '2.69'
  compatibility 'all'
  source_url 'ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz'
  source_sha256 '64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf-2.69-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf-2.69-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf-2.69-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/autoconf-2.69-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18bb14e7e51ec1a76627f99976a28a14a82c29994370b261433550d5c8c461cc',
     armv7l: '18bb14e7e51ec1a76627f99976a28a14a82c29994370b261433550d5c8c461cc',
       i686: '99e6837ba27895c1ca73826bcbc05ec6363351c74caea3a43dc26c05c55ffffa',
     x86_64: '6e9469eefc244fbe7754a3ae88e74fa8892f8676084a6c9ea2ec5b4d49a36c6b',
  })

  depends_on 'perl'
  depends_on 'm4'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
