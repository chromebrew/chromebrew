require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.119'
  source_url 'https://launchpadlibrarian.net/322131788/byobu_5.119.orig.tar.gz'
  source_sha256 '4b092ca12d3a33e89d84cc90c4a41af2ba8697d48e26080a45d64d6b7800ca77'

  depends_on 'gawk'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
