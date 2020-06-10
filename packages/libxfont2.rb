require 'package'

class Libxfont2 < Package
  description 'X.org X font library'
  homepage 'http://www.x.org'
  version '2.0.3'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXfont2-2.0.3.tar.gz'
  source_sha256 'a4b761a37528353a2b83dba364d7c1fd6aef2d554a1a019815f24f7f8866890e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfont2-2.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxfont2-2.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxfont2-2.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxfont2-2.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1164f62cdb02e6872fb2d663538816e349741f1d9ad8b92eecfc418960451397',
     armv7l: '1164f62cdb02e6872fb2d663538816e349741f1d9ad8b92eecfc418960451397',
       i686: 'aff523b36033681838e9583ba8521024d3728b2cce66b6a5fa071bb5e428d2fc',
     x86_64: '5529d1c979afd016f0358227c8db38224cb46f81204726b0ca270bb4ce283608',
  })

  depends_on 'libxtrans'
  depends_on 'libfontenc'
  depends_on 'libx11'
  depends_on 'freetype'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
