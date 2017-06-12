require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.5'
  source_url 'http://apache.mirrors.ionfish.org/subversion/subversion-1.9.5.tar.gz'
  source_sha1 'ac9f8ee235f1b667dd6506864af8035aaedfc2d9'

  depends_on 'aprutil'
  depends_on 'sqlite'
  depends_on 'serf'

  def self.build
    system './configure --prefix=/usr/local --with-apr=/usr/local --with-apr-util=/usr/local'
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
