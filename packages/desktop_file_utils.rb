require 'package'

class Desktop_file_utils < Package
  description 'contains a few command line utilities for working with desktop entries'
  homepage 'https://www.freedesktop.org/wiki/Software/desktop-file-utils/'
  version '0.23'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.23.tar.xz'
  source_sha256 '6c094031bdec46c9f621708f919084e1cb5294e2c5b1e4c883b3e70cb8903385'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/desktop_file_utils/0.23_armv7l/desktop_file_utils-0.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/desktop_file_utils/0.23_armv7l/desktop_file_utils-0.23-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/desktop_file_utils/0.23_i686/desktop_file_utils-0.23-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/desktop_file_utils/0.23_x86_64/desktop_file_utils-0.23-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b13f9202b0b0f3d36a7fc0df45a7f321eebf1efc870aa553b2e8c435bfa1a063',
     armv7l: 'b13f9202b0b0f3d36a7fc0df45a7f321eebf1efc870aa553b2e8c435bfa1a063',
       i686: 'af80702f193a3ec436b122b9f20889b196d51eac01c7c2c5b6e432e466a2c303',
     x86_64: '3f2a161ca73edca9d51619b39bd27acd23eb6259947f41a2d2bfda3a2720695c'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
