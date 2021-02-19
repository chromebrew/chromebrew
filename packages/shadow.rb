require 'package'

class Shadow < Package
  description 'Shadow password file utilities'
  homepage 'https://github.com/shadow-maint/shadow'
  @_ver = '4.8.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/shadow-maint/shadow/releases/download/#{@_ver}/shadow-#{@_ver}.tar.xz"
  source_sha256 'a3ad4630bdc41372f02a647278a8c3514844295d36eefe68ece6c3a641c1ae62'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/shadow-4.8.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2f7ed952af80df7d0d57c68b1983d8de34fa29a8f66eec28ecd41f9efafea1c0',
     armv7l: '2f7ed952af80df7d0d57c68b1983d8de34fa29a8f66eec28ecd41f9efafea1c0',
       i686: 'a4d2a90a7993693ccb2935dadd9c4af1bc1465fe20868df7b1255a3603cfb9a2',
     x86_64: 'd267579cb8a22d4a6378cd7c69033197cb685a7f2fc054b95707db3e400f8b8f'
  })

  depends_on 'linux_pam'

  def self.build
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --bindir=#{CREW_PREFIX}/bin \
      --sbindir=#{CREW_PREFIX}/bin \
      --enable-shared \
      --with-libpam \
      --without-selinux \
      --with-acl \
      --with-attr \
      --disable-nls \
      --enable-subordinate-ids \
      --disable-account-tools-setuid"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
