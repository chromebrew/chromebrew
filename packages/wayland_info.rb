require 'buildsystems/meson'

class Wayland_info < Meson
  description 'wayland-info is a utility for displaying information about the Wayland protocols supported by a Wayland compositor.'
  homepage 'https://gitlab.freedesktop.org/wayland/wayland-utils'
  version '1.2.0'
  license 'MIT/Expat'
  compatibility 'all'
  min_glibc '2.34'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-utils.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe9c7444babd95c443f4807a08a5f5441d7c0827f53e5c2a4a38fd083e6edec1',
     armv7l: 'fe9c7444babd95c443f4807a08a5f5441d7c0827f53e5c2a4a38fd083e6edec1',
       i686: '93adf54ced18ea647a10be36a96c1e2b369149d5d6a584b55d30818ab88ab479',
     x86_64: '74ab29066adc68ed529bee0f1e57314a9244b5d9bb2109c193c52ebf5a709851'
  })

  depends_on 'glibc' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols' => :build
end
