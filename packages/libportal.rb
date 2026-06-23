require 'buildsystems/meson'

class Libportal < Meson
  description 'libportal provides GIO-style async APIs for most Flatpak portals.'
  homepage 'https://github.com/flatpak/libportal'
  version '0.10.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/flatpak/libportal.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e4531cb94b5e547f51834cfb3459d943a18e96f5cb94b427d63a4219eabda8e5',
     armv7l: 'e4531cb94b5e547f51834cfb3459d943a18e96f5cb94b427d63a4219eabda8e5',
     x86_64: '65d52d8c90a99785004a147a57cc91b2c76e943afe03c3cccb9c671c1f8d8a13'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :library
  depends_on 'gtk4' => :library
  depends_on 'vala' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build

  meson_options '-Ddocs=false -Dportal-tests=false -Dtests=false'
end
