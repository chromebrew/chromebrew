require 'buildsystems/meson'

class Libportal < Meson
  description 'libportal provides GIO-style async APIs for most Flatpak portals.'
  homepage 'https://github.com/flatpak/libportal'
  version '0.9.1'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/flatpak/libportal.git'
  git_hashtag version
  source_sha256 '8ad326c4f53b7433645dc86d994fef0292bee8adda0fe67db9288ace19250a9c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '703ee0582fdf3999400ec69eb24208ca09e646e5519623d9c2eb681a9f9bd611',
     armv7l: '703ee0582fdf3999400ec69eb24208ca09e646e5519623d9c2eb681a9f9bd611',
     x86_64: 'd0ed166b4c9437e9660fb1de34de0ba7d84ba38a6120fe35aa288862e79db532'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'vala' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  meson_options '-Ddocs=false \
    -Dportal-tests=false \
    -Dtests=false'
end
