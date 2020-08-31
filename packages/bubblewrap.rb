require 'package'

class Bubblewrap < Package
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  version '0.4.1'
  compatibility 'all'
  source_url 'https://github.com/containers/bubblewrap/releases/download/v0.4.1/bubblewrap-0.4.1.tar.xz'
  source_sha256 'b9c69b9b1c61a608f34325c8e1a495229bacf6e4a07cbb0c80cf7a814d7ccc03'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'eba5493670c286fae9c71814b32613d7c7a951b037680a3f2fbf853c69c53db7',
     armv7l: 'eba5493670c286fae9c71814b32613d7c7a951b037680a3f2fbf853c69c53db7',
       i686: '325f997d3d68713b29b8db744b278a9d9b3fe5649d934cfb2f3091a8b66a9b50',
     x86_64: '4bdc8a377adb978ddd56a3600e07eed238837e39011b3c8c72f69ef1cf9dc6a8',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --disable-man"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
