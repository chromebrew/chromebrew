require 'package'

class Desktop_file_utils < Package
  description 'contains a few command line utilities for working with desktop entries'
  homepage 'https://www.freedesktop.org/wiki/Software/desktop-file-utils/'
  version '0.23'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.23.tar.xz'
  source_sha256 '6c094031bdec46c9f621708f919084e1cb5294e2c5b1e4c883b3e70cb8903385'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/desktop_file_utilities-0.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/desktop_file_utilities-0.23-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/desktop_file_utilities-0.23-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/desktop_file_utilities-0.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '96410e0ccb06559e86ceeaf828a4992d6701efe98ca69a6cd3d7772d19a388cd',
     armv7l: '96410e0ccb06559e86ceeaf828a4992d6701efe98ca69a6cd3d7772d19a388cd',
       i686: 'd59bdb9a64f6b4e40a402e4c7066ca5459dcb44f97e04328aa99b2eae05f818b',
     x86_64: '46250a48e6d83c2944ccfc3e59f79ccd2d0c4d883088be90f77d540030b0d554',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
