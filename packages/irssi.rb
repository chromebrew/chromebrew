require 'package'

class Irssi < Package
  description 'Modular text mode IRC client with Perl scripting'
  homepage 'https://irssi.org/'
  version '1.2.2'
  source_url 'https://github.com/irssi/irssi/releases/download/1.2.2/irssi-1.2.2.tar.xz'
  source_sha256 '6727060c918568ba2ff4295ad736128dba0b995d7b20491bca11f593bd857578'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib' => :build

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
