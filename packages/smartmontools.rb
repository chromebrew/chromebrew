require 'package'

class Smartmontools < Package
  description 'The smartmontools package contains two utility programs (smartctl and smartd) to control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (SMART) built into most modern ATA/SATA, SCSI/SAS and NVMe disks.'
  homepage 'https://www.smartmontools.org/'
  version '7.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/smartmontools/smartmontools.git'
  git_hashtag "RELEASE_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b867b49bf0e9b7007fd593cec631b15b2dd8e7bccb8948cb1786de5522e8b56c',
     armv7l: 'b867b49bf0e9b7007fd593cec631b15b2dd8e7bccb8948cb1786de5522e8b56c',
    i686: '3110b88c1b8e1f48076b44f8fe9d5ede7e49d68fed0c690a106dd75f01640200',
  x86_64: 'fa71dd17b09bbb6fc3e0acf345c1bd499592c415842a7f16d22e388d87c185aa'
  })

  depends_on 'gpgme'

  def self.build
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS} --with-nvme-devicescan --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
