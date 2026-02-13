require 'buildsystems/meson'

class Libinput < Meson
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput/'
  version '1.31.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8aa59af187aa02624886f65d23f78618c53602c7564b22df97f128113cd3344b',
     armv7l: '8aa59af187aa02624886f65d23f78618c53602c7564b22df97f128113cd3344b',
     x86_64: 'ebbfd6d839cedc1105c03fa41ace954f89db56425880895241bc9ef446221e22'
  })

  depends_on 'check' => :build
  depends_on 'eudev' # R
  depends_on 'glibc' # R
  # depends_on 'graphviz' => :build
  # depends_on 'gtk3' => :build
  depends_on 'libevdev' # R
  depends_on 'libunwind' => :build
  depends_on 'libwacom' # R
  depends_on 'mtdev' # R
  depends_on 'valgrind' => :build

  # If debug-gui feature is required, uncomment following lines and remove "-Ddebug-gui=false" to enable it

  meson_options '-Ddebug-gui=false \
      -Ddocumentation=false'
end
