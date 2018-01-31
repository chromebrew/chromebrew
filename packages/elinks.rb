require 'package'

class Elinks < Package
  description 'Full-Featured Text WWW Browser'
  homepage 'http://elinks.or.cz/'
  version 'f86be659'

  source_url 'https://gitlab.com/alanaktion/elinks-mirror/repository/f86be659718c0cd0a67f88b42f07044c23d0d028/archive.tar.gz'
  source_sha256 'c19a342a5a6716b5213a4c539a149711491136d8b12daba7846bc2225c5fb309'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be659-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be659-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be659-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be659-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c715668400a4065542f82b32f3ad459549783eae859204fa9223385be4e1aa04',
     armv7l: 'c715668400a4065542f82b32f3ad459549783eae859204fa9223385be4e1aa04',
       i686: '0f871561f1a9bc6bba4be57576888a45b217dc5783a3fb7c184d465519779ff2',
     x86_64: 'cf7dfba80f9c66c31f4d2136db0a39043e38eaea217b6a04f20fe16737b248a8',
  })

  depends_on 'bz2'
  depends_on 'lzip'
  depends_on 'openssl'
  depends_on 'zlibpkg'
  depends_on 'libx11'

  def self.build
    system "wget -O config/config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "wget -O config/config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
    system "sh autogen.sh" unless File.executable? "configure"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
