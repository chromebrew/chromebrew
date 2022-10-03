require 'package'

class Datamash < Package
  description 'GNU Datamash is a command-line program which performs basic numeric, textual and statistical operations on input textual data files.'
  homepage 'https://www.gnu.org/software/datamash'
  version '1.8'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/datamash/datamash-1.8.tar.gz'
  source_sha256 '7ad97e8c7ef616dd03aa5bd67ae24c488272db3e7d1f5774161c18b75f29f6fd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/datamash/1.8_armv7l/datamash-1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/datamash/1.8_armv7l/datamash-1.8-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/datamash/1.8_i686/datamash-1.8-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/datamash/1.8_x86_64/datamash-1.8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a5c3eccb59d8a85d3b6f171b7c1df2b153676dbbda431426660716a9ebf96db5',
     armv7l: 'a5c3eccb59d8a85d3b6f171b7c1df2b153676dbbda431426660716a9ebf96db5',
       i686: '460e8b86133b5813a38b9f83b6fc205979eae456954d2a0228a3ac4e252c2282',
     x86_64: '488eaf7f76c84ca7632aacf55e87293a2602129d68bfe9f7780ac51f0af56f52'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
