require 'buildsystems/meson'

class Cage < Meson
  description 'A kiosk compositor for Wayland'
  homepage 'https://www.hjdskes.nl/projects/cage/'
  version '0.3.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Hjdskes/cage.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8cd15519f33254830ea5a0dd25e3b721240e92f7a15d6de9039a9950ff92f316',
     armv7l: '8cd15519f33254830ea5a0dd25e3b721240e92f7a15d6de9039a9950ff92f316',
     x86_64: '19e2760310d262b1579ba210aa917fb15961cb3cc09a2a539c6f0f7bf15d82f7'
  })

  depends_on 'glibc' => :executable
  depends_on 'libxkbcommon' => :executable
  depends_on 'pixman' => :build
  depends_on 'scdoc' => :build
  depends_on 'wayland' => :executable
  depends_on 'wayland_protocols' => :build
  depends_on 'wlroots' => :executable
end
