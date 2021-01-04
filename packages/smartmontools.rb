require 'package'

class Smartmontools < Package
  description 'The smartmontools package contains two utility programs (smartctl and smartd) to control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (SMART) built into most modern ATA/SATA, SCSI/SAS and NVMe disks.'
  homepage 'https://www.smartmontools.org/'
  version '7.2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/smartmontools/smartmontools/7.2/smartmontools-7.2.tar.gz'
  source_sha256 '5cd98a27e6393168bc6aaea070d9e1cd551b0f898c52f66b2ff2e5d274118cd6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/smartmontools-7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/smartmontools-7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/smartmontools-7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/smartmontools-7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ac90e2813866209afb1a854571f3223be3af25a897be70c4253ecd07727c10ec',
     armv7l: 'ac90e2813866209afb1a854571f3223be3af25a897be70c4253ecd07727c10ec',
       i686: 'a23fa22c6669b2b959c4637c524dc8a0f3d54b8064b9d6c325682ac65c1d5db8',
     x86_64: 'bcf4a50b737ac859717f4edc061c77e7ec793c1e69c652c0e06455ac5bf25bf2',
  })

  depends_on 'gpgme'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-nvme-devicescan --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
