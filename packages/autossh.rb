require 'package'

class Autossh < Package
  description 'The purpose of autossh is to start an SSH connection, monitor it, and restart it if necessary.'
  homepage 'http://www.harding.motd.ca/autossh'
  # No releases available so the only option is to use the master branch
  version '9c72d3'
  source_url 'https://github.com/jonhiggs/autossh/archive/9c72d3b6f77bfe2ad57844128ea46019fecb7fdb.tar.gz'
  source_sha256 '39497e1ccd80f781282e8f6387bb3ae5b1501807a39aeced95e8be57c3778cba'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
