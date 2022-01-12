require 'package'

class Zvbi < Package
  description 'The Zapping VBI library, in short ZVBI, provides functions to capture and decode VBI data.'
  homepage 'http://zapping.sourceforge.net/ZVBI/'
  version '0.2.35-1'
  compatibility 'all'
  license 'GPL-2 and LGPL-2'
  source_url 'https://downloads.sourceforge.net/project/zapping/zvbi/0.2.35/zvbi-0.2.35.tar.bz2'
  source_sha256 'fc883c34111a487c4a783f91b1b2bb5610d8d8e58dcba80c7ab31e67e4765318'

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35-1_armv7l/zvbi-0.2.35-1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35-1_armv7l/zvbi-0.2.35-1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35-1_i686/zvbi-0.2.35-1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35-1_x86_64/zvbi-0.2.35-1-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
     aarch64: '41b4539eea8ae06c8ba26874c084cbda7fb2f241e6529bcb2e22906fb81f6ce7',
      armv7l: '41b4539eea8ae06c8ba26874c084cbda7fb2f241e6529bcb2e22906fb81f6ce7',
        i686: '2957624655028f18bb32a4ddc5a19b6a114daa756fb4ccdfb61fb44e163bde22',
      x86_64: 'a7ae368f0e5f3d010a44928d0536f809aaca88b28ffe5a037d4e2d31349c9603',
  })

  depends_on 'libpng'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
