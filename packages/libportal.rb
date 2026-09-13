require 'buildsystems/meson'

class Libportal < Meson
  description 'libportal provides GIO-style async APIs for most Flatpak portals.'
  homepage 'https://github.com/flatpak/libportal'
  version '0.11.0'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/flatpak/libportal.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bcc40aa1bea6bdb4677fd4e939408aa01ab94daaa20efac964f4cb9f44bf911',
     armv7l: '5bcc40aa1bea6bdb4677fd4e939408aa01ab94daaa20efac964f4cb9f44bf911',
     x86_64: '4f9a658f03fbb661309130ac48d0bd7268f09036dde7c9c79ceac3ebc106da40'
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
