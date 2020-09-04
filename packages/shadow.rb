require 'package'

class Shadow < Package
  description 'Shadow password file utilities'
  homepage 'https://github.com/shadow-maint/shadow'
  version '4.8.1'
  compatibility 'all'
  source_url 'https://github.com/shadow-maint/shadow/releases/download/4.8.1/shadow-4.8.1.tar.xz'
  source_sha256 'a3ad4630bdc41372f02a647278a8c3514844295d36eefe68ece6c3a641c1ae62'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '52d073915c219d4402907e47a32e89c1f61585c36d4cb608fcb6bcb03ed4f44e',
     armv7l: '52d073915c219d4402907e47a32e89c1f61585c36d4cb608fcb6bcb03ed4f44e',
       i686: 'e7559741bb901a45e9d98fd989750d6df0501611e81fa56af83014016df7e29a',
     x86_64: '562849baf46b40c5e015c369ae77cc2f92266309acbc2b0cc1e87c0f0fa7a72b',
  })

  depends_on 'openpam'

  def self.build
    system "./configure #{CREW_OPTIONS} --bindir=#{CREW_PREFIX}/bin --sbindir=#{CREW_PREFIX}/bin \
--enable-shared --disable-static --with-libpam --without-selinux --with-acl --with-attr --without-su \
--disable-nls --enable-subordinate-ids --disable-account-tools-setuid"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
