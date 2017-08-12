require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.7'
  source_url 'http://www-us.apache.org/dist/subversion/subversion-1.9.7.tar.bz2'
  source_sha256 'c3b118333ce12e501d509e66bb0a47bcc34d053990acab45559431ac3e491623'

  depends_on 'aprutil'
  depends_on 'autoconf'
  depends_on 'libtool'
  depends_on 'serf'
  depends_on 'sqlite'
  depends_on 'zlibpkg'

  def self.build
    system './configure', '--disable-static', "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
