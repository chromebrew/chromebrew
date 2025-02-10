require 'buildsystems/meson'

class Libportal < Meson
  description 'libportal provides GIO-style async APIs for most Flatpak portals.'
  homepage 'https://github.com/flatpak/libportal'
  version '0.8.1'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/flatpak/libportal.git'
  git_hashtag version
  source_sha256 '8ad326c4f53b7433645dc86d994fef0292bee8adda0fe67db9288ace19250a9c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99a2d190d5b99e391625ad833188f8cf59c745b42e09475cebdddb8d1af640d6',
     armv7l: '99a2d190d5b99e391625ad833188f8cf59c745b42e09475cebdddb8d1af640d6',
     x86_64: '74764a5ced5cfd38b12c8415a656115a2eb037967b071c9a85d50fa5e6506fd8'
  })

  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'gtk4' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  meson_options '-Ddocs=false \
    -Dintrospection=false \
    -Dportal-tests=false \
    -Dtests=false'
end
