require 'package'

class Jq < Package
  version '1.5' 
  source_url 'https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz' 
  source_sha1 '6eef3705ac0a322e8aa0521c57ce339671838277' 

  def self.build
    system "./configure",
      "--prefix=/usr/local",
      "--disable-maintainer-mode", # disable make rules and dependencies not useful
      "--disable-docs"             # there's no support for manpages
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
