require "package"

class Sfk < Package
  description 'The Swiss File Knife - A Command Line Tools Collection for Windows / Linux / Mac.'
  homepage 'http://swissfileknife.sourceforge.net/'
  version "1.8.6"
  source_url "https://sourceforge.net/projects/swissfileknife/files/1-swissfileknife/1.8.6/sfk-1.8.6.tar.gz"
  source_sha1 "d45d80d8a452d121ad85ec1d909fb3f85c17ee3f"

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

