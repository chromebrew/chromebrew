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
    aarch64: 'a92cad41827ee044bb221e34c0f19067d9b2a09d2be3b0262b282b605d2ffe00',
     armv7l: 'a92cad41827ee044bb221e34c0f19067d9b2a09d2be3b0262b282b605d2ffe00',
     x86_64: '7d64271ba1e987af83ab4531b4759ba22c70a4b26a20b633c3c4194371ef9e29'
  })

  # depends_on 'graphviz' => :build
  # depends_on 'gtk3' => :build
  depends_on 'check' => :build
  depends_on 'eudev' # R
  depends_on 'glibc' # R
  depends_on 'libevdev' # R
  depends_on 'libunwind' => :build
  depends_on 'libwacom' # R
  depends_on 'mtdev' # R
  depends_on 'valgrind' => :build

  # If debug-gui feature is required, uncomment following lines and remove "-Ddebug-gui=false" to enable it

  meson_options '-Ddebug-gui=false \
      -Ddocumentation=false'
end
