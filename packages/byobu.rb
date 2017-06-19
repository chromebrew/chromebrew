require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.119'
  source_url 'https://launchpadlibrarian.net/322131788/byobu_5.119.orig.tar.gz'
  source_sha1 '1d8d07da4c94c4adeb662a7f8b33fe02482d9839'

  depends_on 'gawk'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
