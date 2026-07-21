require 'package'

class Pdfcrack < Package
  description 'pdfcrack is a command line, password recovery tool for PDF-files.'
  homepage 'https://sourceforge.net/projects/pdfcrack/'
  version '0.21'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://sourceforge.net/projects/pdfcrack/files/pdfcrack/pdfcrack-#{version}/pdfcrack-#{version}.tar.gz"
  source_sha256 '26f00d4afcb70b5839047bc6f62e4253073ac437bdb526f01e8c04b220e97762'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '021b66bc71dc94a89e2cb80cef566505fbf45baac2135b805952cdd9da38e048',
     armv7l: '021b66bc71dc94a89e2cb80cef566505fbf45baac2135b805952cdd9da38e048',
       i686: '0cf5afad35cdc32108a84a1b6629ead0b0d58f27fe4593f57374c3368446273d',
     x86_64: '1d0dc532320ddb6ecdc188a192ebcee5519ce74429d79062ca2a96bc84532c3c'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'pdfcrack', "#{CREW_DEST_PREFIX}/bin/pdfcrack", mode: 0o755
    FileUtils.install 'pdfcrack.1', "#{CREW_DEST_MAN_PREFIX}/man1/pdfcrack.1", mode: 0o644
  end
end
