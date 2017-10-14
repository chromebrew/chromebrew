require 'package'

class Autossh < Package
  description 'The purpose of autossh is to start an SSH connection, monitor it, and restart it if necessary.'
  homepage 'http://www.harding.motd.ca/autossh'
  # No releases available so the only option is to use the master branch
  version '9c72d3b'
  source_url 'https://github.com/jonhiggs/autossh/archive/9c72d3b6f77bfe2ad57844128ea46019fecb7fdb.tar.gz'
  source_sha256 '39497e1ccd80f781282e8f6387bb3ae5b1501807a39aeced95e8be57c3778cba'

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
