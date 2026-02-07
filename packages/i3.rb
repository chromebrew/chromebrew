require 'buildsystems/meson'

class I3 < Meson
  description 'Improved tiling window manager'
  homepage 'https://i3wm.org/'
  version '4.25.1'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/i3/i3.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6146d44cb28ac210d974005c341a794eeab216e775e9bd7815daecf6435d00f',
     armv7l: 'a6146d44cb28ac210d974005c341a794eeab216e775e9bd7815daecf6435d00f',
     x86_64: '91a1401b559ef961a0f4d3bc5498770b96c37b22f76f7c657ad5088d01cdd454'
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
  depends_on 'sommelier' => :logical
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
