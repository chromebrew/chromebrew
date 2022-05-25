require 'package'

class Motif < Package
  description 'Motif is a freely available source code distribution for the Motif user interface component toolkit.'
  homepage 'https://motif.ics.com/'
  version '2.3.8-1'
  license 'LGPL-2.1+ and MIT'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/motif/Motif%202.3.8%20Source%20Code/motif-2.3.8.tar.gz'
  source_sha256 '859b723666eeac7df018209d66045c9853b50b4218cecadb794e2359619ebce7'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/motif/2.3.8-1_armv7l/motif-2.3.8-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/motif/2.3.8-1_armv7l/motif-2.3.8-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/motif/2.3.8-1_i686/motif-2.3.8-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/motif/2.3.8-1_x86_64/motif-2.3.8-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5de7b5fb40d604071d404f5baba20eef3746caaa6850c40730f4aa36472aa016',
     armv7l: '5de7b5fb40d604071d404f5baba20eef3746caaa6850c40730f4aa36472aa016',
       i686: '60a1013b3e7b8ab41c8809ace6683e5b13115ef577662c3b58df5e0f226669e1',
     x86_64: '9e9936ac3c75240ad36814eaf97d6004674aead89d23ad688f1bdcaa12070529'
  })

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'sommelier'
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libbsd' # R
  depends_on 'libice' # R
  depends_on 'libmd' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxft' # R
  depends_on 'libxmu' # R
  depends_on 'libxrender' # R
  depends_on 'libxt' # R
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --with-x \
      --enable-xft \
      --enable-png \
      --enable-jpeg"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
