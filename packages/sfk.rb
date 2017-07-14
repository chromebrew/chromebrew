require 'package'

class Sfk < Package
  description 'The Swiss File Knife - A Command Line Tools Collection for Windows / Linux / Mac.'
  homepage 'http://swissfileknife.sourceforge.net/'
  version '1.8.6'
  source_url 'https://sourceforge.net/projects/swissfileknife/files/1-swissfileknife/1.8.6/sfk-1.8.6.tar.gz'
  source_sha256 'e65ec60b529785accdb90a77c99376888898764b2d79f6d4280077992994b1e2'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

