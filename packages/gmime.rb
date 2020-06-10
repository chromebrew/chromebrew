require 'package'

class Gmime < Package
  description 'GMime is a powerful MIME (Multipurpose Internet Mail Extension) utility library. It is meant for creating, editing, and parsing MIME messages and structures.'
  homepage 'https://developer.gnome.org/gmime/'
  version '3.2.3'
  compatibility 'all'
  source_url 'https://github.com/jstedfast/gmime/archive/3.2.3.tar.gz'
  source_sha256 '5190dd45e297e2bdeca4b14b7055d37ec07b0fa1fe936159bdb69ddb7c91dd53'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gmime-3.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gmime-3.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gmime-3.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gmime-3.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aba50d887f3654b629d771b3a2a8545a88fd88b115b85b36c4c0ca851094628f',
     armv7l: 'aba50d887f3654b629d771b3a2a8545a88fd88b115b85b36c4c0ca851094628f',
       i686: '7d88fded92d616d666548a60b655626d80b1a5edaa53726e26d71e407673b3a6',
     x86_64: '221c5d7bcb23ea1a985eb6cbf1834e1d3438f481ae3b1a33cc3a7069a8c06378',
  })

  depends_on 'glib'
  depends_on 'gpgme'
  depends_on 'vala'

  def self.build
    system './autogen.sh',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
