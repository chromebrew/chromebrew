# Adapted from Arch Linux spice-protocol PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/spice-protocol/trunk/PKGBUILD

require 'buildsystems/meson'

class Spice_protocol < Meson
  description 'Headers for SPICE protocol'
  homepage 'https://spice-space.org'
  version '0.14.5'
  license 'BSD LGPL2.1'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/spice/spice-protocol/-/archive/v#{version}/spice-protocol-v#{version}.tar.gz"
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0141eeddee746a621f07f02347fa1f8f100d7c156aa6bd9f4f8cbfbafec9aec3',
     armv7l: '0141eeddee746a621f07f02347fa1f8f100d7c156aa6bd9f4f8cbfbafec9aec3',
       i686: '91dc4afb7c90f9a96cc095b1c6b84a7e875dfa5ab8bdc828e17eb246fb8f5b00',
     x86_64: '04e68ec8db0e11a5b552f1c17a5bc11bf93fa9a85e21f7a8875c66c777d58ffb'
  })
end
