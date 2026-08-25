require 'buildsystems/meson'

class Wl_clipboard < Meson
  description 'Command-line copy/paste utilities for Wayland'
  homepage 'https://github.com/bugaevc/wl-clipboard'
  version '2.3.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/bugaevc/wl-clipboard.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51f8d71f255a2dfc9c0df8ca854215b310333ed55176e066cfb5da5ac82c0426',
     armv7l: '51f8d71f255a2dfc9c0df8ca854215b310333ed55176e066cfb5da5ac82c0426',
       i686: '1cf71502f8877df59c1b7953057eb93252fd8e0344663afa594b1404caf525ff',
     x86_64: '26bfb929964f1fa71050af2a5478897a06f0e2dc94ba1efd5c36d6d407979b50'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'wayland' => :executable
  depends_on 'wayland_protocols' # xdg-shell support, depends on wayland
  depends_on 'xdg_utils' # content type inference in wl-copy
end
