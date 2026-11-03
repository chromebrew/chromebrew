require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.50'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5080b647fab620fb2c99610022a711d182f2b212f984ff08856989685a3a166',
     armv7l: 'a5080b647fab620fb2c99610022a711d182f2b212f984ff08856989685a3a166',
       i686: '9232990732232b21820e9ec3f189b8635790a88e1fba54e4133f17760d9ac2b0',
     x86_64: 'd54d3865f524b06eb05f7ca9308425a5257a51d49864d5cdfd1f05b0100fa0f8'
  })

  depends_on 'wayland' => :logical

  meson_options '-Dtests=false'
end
