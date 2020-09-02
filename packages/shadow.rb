require 'package'

class Shadow < Package
  description 'Shadow password file utilities'
  homepage 'https://github.com/shadow-maint/shadow'
  version '4.8.1'
  compatibility 'all'
  source_url 'https://github.com/shadow-maint/shadow/releases/download/4.8.1/shadow-4.8.1.tar.xz'
  source_sha256 'a3ad4630bdc41372f02a647278a8c3514844295d36eefe68ece6c3a641c1ae62'

  depends_on 'openpam'

  def self.build
      system "./configure #{CREW_OPTIONS} --bindir=#{CREW_PREFIX}/bin --sbindir=#{CREW_PREFIX}/bin --enable-shared \ 
--disable-static --with-libpam --without-selinux --with-acl --with-attr --without-su --disable-nls --enable-subordinate-ids --disable-account-tools-setuid"
      system "make"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
