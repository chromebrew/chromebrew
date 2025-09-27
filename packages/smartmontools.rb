require 'buildsystems/autotools'

class Smartmontools < Autotools
  description 'The smartmontools package contains two utility programs (smartctl and smartd) to control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (SMART) built into most modern ATA/SATA, SCSI/SAS and NVMe disks.'
  homepage 'https://www.smartmontools.org/'
  version '7.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/smartmontools/smartmontools.git'
  git_hashtag "RELEASE_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d519e0df3d05336113254d985120c722a21f73818f4c7677238df470d1bd27f',
     armv7l: '7d519e0df3d05336113254d985120c722a21f73818f4c7677238df470d1bd27f',
       i686: '4d409d8259e8ded32464d5dae0f983874be354e0fd93457cf7cd7bbc286c3946',
     x86_64: 'f069146b0e107ff66d93bb6287fb6f74bd2a82d8e7e73e8b8576678a418ab7cb'
  })

  depends_on 'gpgme'

  autotools_configure_options '--with-nvme-devicescan --disable-maintainer-mode'

  def self.prebuild
    system 'autoreconf -fiv'
  end
end
