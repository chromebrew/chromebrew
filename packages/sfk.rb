require 'package'

class Sfk < Package
  description 'The Swiss File Knife - A Command Line Tools Collection for Windows / Linux / Mac.'
  homepage 'http://swissfileknife.sourceforge.net/'
  version '1.8.9'
  source_url 'https://downloads.sourceforge.net/project/swissfileknife/1-swissfileknife/1.8.9.0/sfk-1.8.9.tar.gz'
  source_sha256 '0f974f491d28bf5442d94f9ddeb983bfc69ead96842965ad55152969381fcd8e'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

