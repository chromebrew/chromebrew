require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.47'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ae3d7455fd139d98caa53a0e6a3eb87b80083daff3a2eb418e1530329daa82c',
     armv7l: '4ae3d7455fd139d98caa53a0e6a3eb87b80083daff3a2eb418e1530329daa82c',
       i686: '737f1d56ab72fee69daa356d2cd872a09e05b68310165340380a99f924d8ee3b',
     x86_64: '1f79f3c8e195ade95784e5b9d15bf63e27e6b39c210cde1a808025926c2938ad'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
