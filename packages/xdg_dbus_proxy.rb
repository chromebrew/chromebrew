require 'buildsystems/meson'

class Xdg_dbus_proxy < Meson
  description 'xdg-dbus-proxy is a filtering proxy for D-Bus connections.'
  homepage 'https://github.com/flatpak/xdg-dbus-proxy'
  version '0.1.9'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/flatpak/xdg-dbus-proxy.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03453ccaf914cddc163f434208db13c83e09b7e9a44276e640cb248f8d8d4b87',
     armv7l: '03453ccaf914cddc163f434208db13c83e09b7e9a44276e640cb248f8d8d4b87',
       i686: '7d0f21966ac221f298c272a92f5109bb7162fec26aafdb1b811db16861cad9ae',
     x86_64: 'c5c2fc385a5797c4024a118fdcf470c85a82a85dc6a3408dc36da50f42b61cca'
  })

  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
