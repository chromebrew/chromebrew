require 'package'

class Wl_clipboard < Package
  description 'Command-line copy/paste utilities for Wayland'
  homepage 'https://github.com/bugaevc/wl-clipboard'
  version '2.0.0'
  source_url 'https://github.com/bugaevc/wl-clipboard/archive/v2.0.0.tar.gz'
  source_sha256 '2c42f182432adabe56da0f1144d5fcc40b7aae3d8e14d2bc4dc4c3f91b51808d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'wayland_protocols' # xdg-shell support, depends on wayland
  depends_on 'xdg_utils' # content type inference in wl-copy

  def self.build
    system 'meson', 'build'
    system 'ninja', '-C', 'build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
