require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.5'
  source_url 'http://apache.mirrors.ionfish.org/subversion/subversion-1.9.5.tar.gz'
  source_sha256 '280ba586c5d51d7b976b65d22d5e8e42f3908ed1c968d71120dcf534ce857a83'

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
