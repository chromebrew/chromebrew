require 'package'

class Libxft < Package
  description 'X.org X FreeType interface library'
  homepage 'https://www.x.org'
  version '2.3.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXft-2.3.6.tar.xz'
  source_sha256 '60a6e7319fc938bbb8d098c9bcc86031cc2327b5d086d3335fc5c76323c03022'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxft/2.3.6_armv7l/libxft-2.3.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxft/2.3.6_armv7l/libxft-2.3.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxft/2.3.6_i686/libxft-2.3.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxft/2.3.6_x86_64/libxft-2.3.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1b3530350b911564546426102b9e98649f8368ee24e84349211e6de8934eb7f9',
     armv7l: '1b3530350b911564546426102b9e98649f8368ee24e84349211e6de8934eb7f9',
       i686: '122cf78151a5e1d00ea1dd3a8194818bbcb8faa8d9a223da0d33f62334a5b7fe',
     x86_64: 'bafef43f2fc7087875145273472f333873cfdd6324bbdf286c603ebf76de0768'
  })

  depends_on 'libxrender'
  depends_on 'libx11'
  depends_on 'fontconfig'
  depends_on 'util_macros'
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
