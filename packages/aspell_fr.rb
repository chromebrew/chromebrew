require 'package'

class Aspell_fr < Package
  description 'French Aspell Dictionary'
  homepage 'https://ftpmirror.gnu.org/aspell/dict/0index.html'
  version '0.50-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/aspell/dict/fr/aspell-fr-0.50-3.tar.bz2'
  source_sha256 'f9421047519d2af9a7a466e4336f6e6ea55206b356cd33c8bd18cb626bf2ce91'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_fr-0.50-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_fr-0.50-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_fr-0.50-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_fr-0.50-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c109f726e0a3a7e708a6c8fb4cb1cd7f84d0486fa352c141ce5f70817651efc7',
     armv7l: 'c109f726e0a3a7e708a6c8fb4cb1cd7f84d0486fa352c141ce5f70817651efc7',
       i686: '3a466ebca6ea8267b2ba5e5bcda9b1e15869f11d144b2c282dc5ff40a37d7364',
     x86_64: '8ffcc409bf5c6e4a142b68d027498942788535f8025927de23efa477e1a7d2c1',
  })

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
