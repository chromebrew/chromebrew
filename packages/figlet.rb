require 'package'

class Figlet < Package
  description 'FIGlet is a program for making large letters out of ordinary text.'
  homepage 'http://www.figlet.org/'
  version '2.2.5'
  source_url 'ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-2.2.5.tar.gz'
  source_sha256 'bf88c40fd0f077dab2712f54f8d39ac952e4e9f2e1882f1195be9e5e4257417d'

  def self.build
    system "make", "PREFIX=/usr/local"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
