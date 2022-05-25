require 'package'

class Pdfcrack < Package
  description 'pdfcrack is a command line, password recovery tool for PDF-files.'
  homepage 'https://sourceforge.net/projects/pdfcrack'
  version '0.16'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/pdfcrack/files/pdfcrack/pdfcrack-0.16/pdfcrack-0.16.tar.gz'
  source_sha256 '7865b203074ccfd5c612c8ce00c46ffcb4fabaa26154ce9304dfc668c7cb73ef'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdfcrack/0.16_armv7l/pdfcrack-0.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdfcrack/0.16_armv7l/pdfcrack-0.16-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdfcrack/0.16_i686/pdfcrack-0.16-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pdfcrack/0.16_x86_64/pdfcrack-0.16-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f2aeae2872eddaa3034f024d80a6a10302ba88274c07b77112aac24f7146f4e9',
     armv7l: 'f2aeae2872eddaa3034f024d80a6a10302ba88274c07b77112aac24f7146f4e9',
       i686: '0a8bb96eaaa224e97a6ba6d77890359398cc06c5844e99de19aa63a2e39c7c6d',
     x86_64: 'fe283684679ffe42701876251ef2ae9dc4b19272a91a0df93f968f0e2d148c1b'
  })

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 pdfcrack #{CREW_DEST_PREFIX}/bin/pdfcrack"
  end
end
