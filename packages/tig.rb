require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'https://jonas.github.io/tig/'
  version '2.4.1'
  compatibility 'all'
  source_url 'https://github.com/jonas/tig/releases/download/tig-2.4.1/tig-2.4.1.tar.gz'
  source_sha256 'b6b6aa183e571224d0e1fab3ec482542c1a97fa7a85b26352dc31dbafe8558b8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tig-2.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '712274329587938cdb648fba374338f12f78145a0a69e2285f30a3ac0f2b0eb2',
     armv7l: '712274329587938cdb648fba374338f12f78145a0a69e2285f30a3ac0f2b0eb2',
       i686: '70ed711fb304a329f256e5802983110587e9f3e7c6378a12b73d5a0a6d5f5d36',
     x86_64: '16aa53a2087362bfacb86aada31eccd4614b347b7b3202849c0ce790efc0cfcb',
  })

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}"
    system "sed -i 's,\$(QUIET_LINK),,' Makefile"
    system "sed -i 's,\$(QUIET_CC),,' Makefile"
    system "sed -i 's,\$(QUIET_GEN),,g' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
