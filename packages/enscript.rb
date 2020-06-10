require 'package'

class Enscript < Package
  description 'GNU Enscript is a free replacement for Adobe\'s enscript program.'
  homepage 'https://www.gnu.org/software/enscript/'
  version '1.6.6'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/enscript/enscript-1.6.6.tar.gz'
  source_sha256 '6d56bada6934d055b34b6c90399aa85975e66457ac5bf513427ae7fc77f5c0bb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/enscript-1.6.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/enscript-1.6.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/enscript-1.6.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/enscript-1.6.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '316ed484d08cfbe16632937379a05366b9841e986e351fd3d4061f474e046725',
     armv7l: '316ed484d08cfbe16632937379a05366b9841e986e351fd3d4061f474e046725',
       i686: '4332bbf72b8622a2ecbc84e58f55b1515ce66c3d678c69c1f28402cfc6e2a7e3',
     x86_64: '638519de1bdfc08816d511f8ad468213d78293a77a26295630a0266b664582c9',
  })

  depends_on 'libpth'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
