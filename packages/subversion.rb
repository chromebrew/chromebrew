require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.12'
  source_url 'https://www-us.apache.org/dist/subversion/subversion-1.9.12.tar.bz2'
  source_sha256 '3c3a15fd73a21ab55556d7c291cf40e25ade1c070294504aa50b4767db1be397'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'aprutil'
  depends_on 'serf'
  depends_on 'sqlite'

  def self.build
    system './configure', '--disable-static', "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
