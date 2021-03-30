require 'package'

class Shadow < Package
  description 'Shadow password file utilities'
  homepage 'https://github.com/shadow-maint/shadow'
  @_ver = '4.8.1-1'
  version "#{@_ver}-1"
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://github.com/shadow-maint/shadow/releases/download/#{@_ver}/shadow-#{@_ver}.tar.xz"
  source_sha256 'a3ad4630bdc41372f02a647278a8c3514844295d36eefe68ece6c3a641c1ae62'

  depends_on 'linux_pam'

  def self.build
    system "env CFLAGS='-flto=auto -ltinfow' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
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
