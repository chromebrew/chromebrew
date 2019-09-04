require 'package'

class Wl_clipboard < Package
  description 'Command-line copy/paste utilities for Wayland'
  homepage 'https://github.com/bugaevc/wl-clipboard.git'
  version 'c0109' # Yes, I know, not the greatest version number,
                  #  but it has fixes that 1.0.0 doesn't have yet.
  source_url 'https://github.com/bugaevc/wl-clipboard/archive/c0109.tar.gz'
  source_sha256 '3c7815986bb43c49912e1b64fb447bc31a80aa1326471dd575123ed6cd86e6be'

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
    # Meson and Ninja sadly do not support a command-line
    #  argument for this like Make does
    ENV['DESTDIR'] = CREW_DEST_DIR
    system 'ninja', '-C', 'build', 'install'
  end
end
