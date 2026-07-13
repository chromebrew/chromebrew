require 'buildsystems/meson'

class Cage < Meson
  description 'A kiosk compositor for Wayland'
  homepage 'https://www.hjdskes.nl/projects/cage/'
  version '0.3.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Hjdskes/cage.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d7c257c140a9ce604c1d48f2e5c109919613d9e39392d8ef81f5990cd64a403',
     armv7l: '1d7c257c140a9ce604c1d48f2e5c109919613d9e39392d8ef81f5990cd64a403',
     x86_64: 'a29905b58d9cbbaf85872a04851ab1d28c41d7e921ca633cd29babb5882b2df3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxkbcommon' => :executable
  depends_on 'pixman' => :build
  depends_on 'scdoc' => :build
  depends_on 'wayland' => :executable
  depends_on 'wayland_protocols' => :build
  depends_on 'wlroots' => :executable
end
