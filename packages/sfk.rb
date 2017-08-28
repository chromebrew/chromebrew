require 'package'

class Sfk < Package
  description 'The Swiss File Knife - A Command Line Tools Collection for Windows / Linux / Mac.'
  homepage 'http://swissfileknife.sourceforge.net/'
  version '1.8.7'
  source_url 'https://sourceforge.net/projects/swissfileknife/files/1-swissfileknife/1.8.7/sfk-1.8.7.tar.gz'
  source_sha256 '1c53d4d9d05af752546c8341a718bf64be99b62491ff91db02ef100e2f93bfc3'

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

