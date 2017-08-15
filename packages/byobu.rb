require 'package'

class Byobu < Package
  description 'Byobu is a GPLv3 open source text-based window manager and terminal multiplexer.'
  homepage 'http://byobu.org/'
  version '5.119'
  source_url 'https://launchpadlibrarian.net/322131788/byobu_5.119.orig.tar.gz'
  source_sha256 '4b092ca12d3a33e89d84cc90c4a41af2ba8697d48e26080a45d64d6b7800ca77'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/byobu-5.119-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/byobu-5.119-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/byobu-5.119-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/byobu-5.119-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9abd65ef1e50517041840f45d0996ba934772064d5d369481eca19d051ab784c',
     armv7l: '9abd65ef1e50517041840f45d0996ba934772064d5d369481eca19d051ab784c',
       i686: 'eace545af06c52b9103fc1bdf6309c14113e8c483c50a8ee9acd2bf43ba24939',
     x86_64: 'fe135c3fe2fd13624759a474b011bfbb1eddfb0c1325d656e7b2b12e1c40d903',
  })

  depends_on 'gawk'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
