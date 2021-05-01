require 'package'

class Zvbi < Package
  description 'The Zapping VBI library, in short ZVBI, provides functions to capture and decode VBI data.'
  homepage 'http://zapping.sourceforge.net/ZVBI/'
  version '0.2.35'
  license 'GPL-2 and LGPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/zapping/zvbi/0.2.35/zvbi-0.2.35.tar.bz2'
  source_sha256 'fc883c34111a487c4a783f91b1b2bb5610d8d8e58dcba80c7ab31e67e4765318'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35_armv7l/zvbi-0.2.35-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35_armv7l/zvbi-0.2.35-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35_i686/zvbi-0.2.35-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zvbi/0.2.35_x86_64/zvbi-0.2.35-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78f0e7cac98dcee9617256ff1ce5fff4e71c83b9fcf986edb6128020de950ccf',
     armv7l: '78f0e7cac98dcee9617256ff1ce5fff4e71c83b9fcf986edb6128020de950ccf',
       i686: 'bdb25d86773c2dfe642b254be5bd567da509ac4546e3ffa2cb15bea24ddbd985',
     x86_64: 'df144f5bf127aad35537b7874fbeddf60847e2d8e956bea44fdd4d6b1ab4eece',
  })

  depends_on 'libpng'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
