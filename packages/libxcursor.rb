require 'package'

class Libxcursor < Package
  description 'X.org X Cursor management library'
  homepage 'http://www.x.org'
  version '1.1.15-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXcursor-1.1.15.tar.gz'
  source_sha256 '449befea2b11dde58ba3323b2c1ec30550013bd84d80501eb56d0048e62251a1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcursor-1.1.15-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6f13dd900d180de34d5fa91feae0d2e388f5f3b851df96dc0652918c765b7ee9',
     armv7l: '6f13dd900d180de34d5fa91feae0d2e388f5f3b851df96dc0652918c765b7ee9',
       i686: 'a7e936b74307fc50916d1b50328ba1424f61ae6a7535bad579dd325a92626294',
     x86_64: 'a8749cfe441d3facd5c1c9a6feabe3e764e7e630d4687ececd83a15fff59e2de',
  })

  depends_on 'libxrender'
  depends_on 'libxfixes'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
