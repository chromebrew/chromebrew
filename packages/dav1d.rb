require 'package'

class Dav1d < Package
  description '**dav1d** is a new **AV1** cross-platform **d**ecoder, open-source, and focused on speed and correctness.'
  homepage 'https://code.videolan.org/videolan/dav1d'
  version '0.4.0'
  compatibility 'all'
  source_url 'http://get.videolan.org/dav1d/0.4.0/dav1d-0.4.0.tar.xz'
  source_sha256 '2553b2e65081c0ec799c11a752ea43ad8f2d11b2fb36a83375972d1a00add823'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dav1d-0.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f6ba95b0a42b98fa23e0550db70779205531b101932b67e06458030f4d2b712',
     armv7l: '8f6ba95b0a42b98fa23e0550db70779205531b101932b67e06458030f4d2b712',
       i686: '8808245f9c03815ada09d3cdc5cde3844050f77fbfae8577808dd6d0783067e6',
     x86_64: 'adb925f84ce45e4276ca13f686ad3588aec5821217e9d042b0190143482ad80b',
  })

  depends_on 'meson' => :build
  depends_on 'nasm' => :build

  def self.build
    system 'meson build --buildtype release'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
