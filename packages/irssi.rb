require 'package'

class Irssi < Package
  description 'Modular text mode IRC client with Perl scripting'
  homepage 'https://irssi.org/'
  version '1.0.5-1'
  source_url 'https://github.com/irssi/irssi/releases/download/1.0.5/irssi-1.0.5.tar.xz'
  source_sha256 'c2556427e12eb06cabfed40839ac6f57eb8b1aa6365fab6dfcd331b7a04bb914'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib' => :build
  depends_on 'ncurses'
  depends_on 'openssl'
  depends_on 'perl'

  def self.build
    system './configure',
	     "--prefix=#{CREW_PREFIX}",
	     "--libdir=#{CREW_LIB_PREFIX}",
	     "--sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
