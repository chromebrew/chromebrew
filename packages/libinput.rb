require 'buildsystems/meson'

class Libinput < Meson
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput/'
  version '1.29.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f990053478f54b3630415c53b0f8bd6f3ae61128bd1e533d6fcdd81fe40ef2d',
     armv7l: '8f990053478f54b3630415c53b0f8bd6f3ae61128bd1e533d6fcdd81fe40ef2d',
       i686: '23210fa0f78aef18c64121f7a2ee0c764877a5602743ce614ee6f9f07998cd61',
     x86_64: '5d71fda96eacee2fd12baff8213e4413294a0a5a77d9d9eb3b482d09222b3c97'
  })

  depends_on 'check' => :build
  depends_on 'eudev' # R
  depends_on 'glibc' # R
  # depends_on 'graphviz' => :build
  # depends_on 'gtk3' => :build
  depends_on 'libevdev' # R
  depends_on 'libunwind' => :build
  depends_on 'libwacom' # R
  depends_on 'libwacom' => :build
  depends_on 'mtdev' # R
  depends_on 'valgrind' => :build

  # If debug-gui feature is required, uncomment following lines and remove "-Ddebug-gui=false" to enable it

  meson_options '-Ddebug-gui=false \
      -Ddocumentation=false'
end
