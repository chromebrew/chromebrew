require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.34'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5a84b3bd77216e1d2a0e90b6258076acdfd641e3eb23b6158755d9ac55c741a',
     armv7l: 'd5a84b3bd77216e1d2a0e90b6258076acdfd641e3eb23b6158755d9ac55c741a',
     x86_64: 'c1a4929efb9e12e73d957a391607ef38451a16770671eec0539a479ba6f3f511'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
