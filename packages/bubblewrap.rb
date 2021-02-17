require 'package'

class Bubblewrap < Package
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  @_ver = '0.4.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/containers/bubblewrap/releases/download/v#{@_ver}/bubblewrap-#{@_ver}.tar.xz"
  source_sha256 'b9c69b9b1c61a608f34325c8e1a495229bacf6e4a07cbb0c80cf7a814d7ccc03'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c37463f10eaab1df36f8d2593d7cb252bc9558c34a4d9763f20418522e65e296',
     armv7l: 'c37463f10eaab1df36f8d2593d7cb252bc9558c34a4d9763f20418522e65e296',
       i686: 'cbc8628fc92ce28e2c3e8c790e6e0af7475486316f863d78391228e022e646ba',
     x86_64: '8dcbe19bcac8722f5d8257bbc6e26e93d86aa959fe2b31ba78a5ce95575cea76'
  })

  depends_on 'libcap' => :build

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure \
      --disable-maintainer-mode \
      --disable-man \
      --with-priv-mode=setuid \
      --enable-sudo"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
