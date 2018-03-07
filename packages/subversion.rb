require 'package'

class Subversion < Package
  description 'Subversion is an open source version control system.'
  homepage 'https://subversion.apache.org/'
  version '1.9.7-1'
  source_url 'http://www-us.apache.org/dist/subversion/subversion-1.9.7.tar.bz2'
  source_sha256 'c3b118333ce12e501d509e66bb0a47bcc34d053990acab45559431ac3e491623'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/subversion-1.9.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/subversion-1.9.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/subversion-1.9.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/subversion-1.9.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '046c3b19f7b19836219bb927dfbb83d32c93d32489c81f4a0145da935d281c65',
     armv7l: '046c3b19f7b19836219bb927dfbb83d32c93d32489c81f4a0145da935d281c65',
       i686: '19ebd0a7cf5ec2fec0e8f34acc32b8da903457eda915ee42f68f301d77542e0b',
     x86_64: '50cc52d28f7ad25b86717310cbae02bf35d8d7b15ea33ed9d4f0e127423ce10e',
  })

  depends_on 'aprutil'
  depends_on 'autoconf'
  depends_on 'libtool'
  depends_on 'serf'
  depends_on 'filecmd'
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
