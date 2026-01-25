require 'buildsystems/meson'

class I3 < Meson
  description 'Improved tiling window manager'
  homepage 'https://i3wm.org/'
  version '4.25'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/i3/i3.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c80e9228de17400f0867ffdc06320a575961036da921b73c02d55792a3255a2a',
     armv7l: 'c80e9228de17400f0867ffdc06320a575961036da921b73c02d55792a3255a2a',
     x86_64: '1bd6abf4f8444c6be265251ca350e20fbc172300e1a36dc3f06d7c1727c8d751'
  })

  depends_on 'cairo' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libev' # R
  depends_on 'libxcb' # R
  depends_on 'libxkbcommon' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'sommelier' # R
  depends_on 'startup_notification' # R
  depends_on 'wayland' => :build
  depends_on 'xcb_util' # R
  depends_on 'xcb_util_cursor' # R
  depends_on 'xcb_util_keysyms' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'xcb_util_xrm' # R
  depends_on 'yajl' # R

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
