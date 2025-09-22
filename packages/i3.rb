require 'buildsystems/meson'

class I3 < Meson
  description 'Improved tiling window manager'
  homepage 'https://i3wm.org/'
  version '4.24'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/i3/i3.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0c0849c2b4b1402fe72e781c963af5aec1d84ac413f8a5616fc38becd1db3d9',
     armv7l: 'd0c0849c2b4b1402fe72e781c963af5aec1d84ac413f8a5616fc38becd1db3d9',
     x86_64: 'a07c0b7f085c716c60f6044a5e2904bb3d77eb392051a808348d408dcd535555'
  })

  depends_on 'cairo' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libev'
  depends_on 'libxcb' # R
  depends_on 'libxkbcommon' # R
  depends_on 'pango'
  depends_on 'pcre2' # R
  depends_on 'sommelier'
  depends_on 'startup_notification'
  depends_on 'wayland' => :build
  depends_on 'xcb_util' # R
  depends_on 'xcb_util_cursor'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_wm'
  depends_on 'xcb_util_xrm'
  depends_on 'yajl'

  meson_install_extras do
    File.write "#{CREW_DEST_PREFIX}/bin/starti3", <<~EOF, perm: 0o755
      #!/bin/sh
      stopsommelier
      export DISPLAY=100.115.92.2:0
      i3 "$@"
      export DISPLAY=:0
      startsommelier
    EOF
  end

  def self.postinstall
    ExitMessage.add <<~EOT.lightblue
      To use this package, you need to download XServer XSDL from Google Play Store.
      Use 'starti3' instead of 'i3' to execute this package.
      Open XServer XSDL before running 'starti3'.
    EOT
  end
end
