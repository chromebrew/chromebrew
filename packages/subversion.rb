require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.6'
  source_url 'http://apache.mirrors.ionfish.org/subversion/subversion-1.9.6.tar.bz2'
  source_sha256 'dbcbc51fb634082f009121f2cb64350ce32146612787ffb0f7ced351aacaae19'

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
