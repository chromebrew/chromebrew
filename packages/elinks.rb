require 'package'

class Elinks < Package
  description 'Full-Featured Text WWW Browser'
  homepage 'http://elinks.or.cz/'
  version 'f86be6597'

  source_url 'https://gitlab.com/alanaktion/elinks-mirror/repository/f86be659718c0cd0a67f88b42f07044c23d0d028/archive.tar.gz'
  source_sha256 'c19a342a5a6716b5213a4c539a149711491136d8b12daba7846bc2225c5fb309'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be6597-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be6597-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be6597-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elinks-f86be6597-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd35ccb21f21db6479c457768465ff70bdd89a4bcbc593d9d07a6805e92c48130',
     armv7l: 'd35ccb21f21db6479c457768465ff70bdd89a4bcbc593d9d07a6805e92c48130',
       i686: '65e2c49a1f8ceb7e764d7ee845fd8d0b5ec46969fae8dfa9728127ae23e88fc5',
     x86_64: '3686325a59d328fd02afa52b0bf07608fefe7c43cf12edafca24743093a0a535',
  })

  depends_on 'automake' => :build
  depends_on 'bz2'
  depends_on 'lzip'
  depends_on 'openssl'
  depends_on 'zlibpkg'

  def self.build
    system "sh autogen.sh"
    system "./configure --without-x --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
