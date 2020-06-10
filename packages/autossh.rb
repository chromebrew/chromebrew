require 'package'

class Autossh < Package
  description 'The purpose of autossh is to start an SSH connection, monitor it, and restart it if necessary.'
  homepage 'http://www.harding.motd.ca/autossh'
  # No releases available so the only option is to use the master branch
  compatibility 'all'
  version '9c72d3b'
  source_url 'https://github.com/jonhiggs/autossh/archive/9c72d3b6f77bfe2ad57844128ea46019fecb7fdb.tar.gz'
  source_sha256 '39497e1ccd80f781282e8f6387bb3ae5b1501807a39aeced95e8be57c3778cba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/autossh-9c72d3b-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/autossh-9c72d3b-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/autossh-9c72d3b-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/autossh-9c72d3b-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd988e2b17d8c06773f099b8c6eb8db198de32af1a7fe2dfc39acd30b83e27db4',
     armv7l: 'd988e2b17d8c06773f099b8c6eb8db198de32af1a7fe2dfc39acd30b83e27db4',
       i686: 'd74acb98fc939fba9aaebf4993639ee3d9f11417ac6184ed1f57a88d4db56214',
     x86_64: '48eda7fb01e8818fad3c0d4d9e3fb9f1b294fa26fe71b41c17e04dd11b3fa043',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/doc/autossh"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/examples/autossh"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp autossh #{CREW_DEST_PREFIX}/bin"
    system "cp CHANGES README #{CREW_DEST_PREFIX}/share/doc/autossh"
    system "cp autossh.host rscreen #{CREW_DEST_PREFIX}/share/examples/autossh"
    system "cp autossh.1 #{CREW_DEST_PREFIX}/man/man1"
  end
end
