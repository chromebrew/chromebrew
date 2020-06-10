require 'package'

class Wl_clipboard < Package
  description 'Command-line copy/paste utilities for Wayland'
  homepage 'https://github.com/bugaevc/wl-clipboard'
  version '2.0.0'
  compatibility 'all'
  source_url 'https://github.com/bugaevc/wl-clipboard/archive/v2.0.0.tar.gz'
  source_sha256 '2c42f182432adabe56da0f1144d5fcc40b7aae3d8e14d2bc4dc4c3f91b51808d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-2.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-2.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-2.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-2.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '66cbdc3e76e9325a561d749cbdf84d2f0bacaef2f3be3c2b0c950f19d466517d',
     armv7l: '66cbdc3e76e9325a561d749cbdf84d2f0bacaef2f3be3c2b0c950f19d466517d',
       i686: 'cf22556aa95ed294281a579c7aa4d1565bfc1be9b6eb1d7295ff0c99e625d39c',
     x86_64: 'a8be7b0810067cbd022df88959262b64d6e03b95b94fc660067afa7b8b0bdeb2',
  })

  depends_on 'wayland_protocols' # xdg-shell support, depends on wayland
  depends_on 'xdg_utils' # content type inference in wl-copy

  def self.build
    system "meson build --prefix #{CREW_PREFIX}"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
