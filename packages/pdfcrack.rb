require 'package'

class Pdfcrack < Package
  description 'pdfcrack is a command line, password recovery tool for PDF-files.'
  homepage 'https://sourceforge.net/projects/pdfcrack'
  version '0.16'
  source_url 'https://sourceforge.net/projects/pdfcrack/files/pdfcrack/pdfcrack-0.16/pdfcrack-0.16.tar.gz'
  source_sha256 '7865b203074ccfd5c612c8ce00c46ffcb4fabaa26154ce9304dfc668c7cb73ef'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 pdfcrack #{CREW_DEST_PREFIX}/bin/pdfcrack"
  end
end
