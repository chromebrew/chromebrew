require 'package'

class Wl_clipboard < Package
  description 'Command-line copy/paste utilities for Wayland'
  homepage 'https://github.com/bugaevc/wl-clipboard.git'
  version 'c0109' # Yes, I know, not the greatest version number,
                  #  but it has fixes that 1.0.0 doesn't have yet.
  source_url 'https://github.com/bugaevc/wl-clipboard/archive/c0109.tar.gz'
  source_sha256 '3c7815986bb43c49912e1b64fb447bc31a80aa1326471dd575123ed6cd86e6be'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-c0109-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-c0109-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-c0109-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wl_clipboard-c0109-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd47f4caf0c77409dc90c3783b24b2033dd6b69388a492096b1048468f388e289',
     armv7l: 'd47f4caf0c77409dc90c3783b24b2033dd6b69388a492096b1048468f388e289',
       i686: '7f4ae7de3f2124c5439118e8fe463009eec9f096abd6e40ed3a364af30c1134e',
     x86_64: '410bb77a3471d12c9babc4466486b7e2785f954fb2399bc5fbf51a555ce361db',
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
