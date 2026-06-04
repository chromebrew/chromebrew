require 'buildsystems/meson'

class Libinput < Meson
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput/'
  version '1.31.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e4e62ac029c12cc62721f3b8d456a1aa68948ffd1f55f7dbb77709e22df683a',
     armv7l: '9e4e62ac029c12cc62721f3b8d456a1aa68948ffd1f55f7dbb77709e22df683a',
     x86_64: '22ea78e69136b1bf0f29136c3b059f889dc7272c0103c83488c658159fbd96cb'
  })

  depends_on 'check' => :build
  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  # depends_on 'graphviz' => :build
  # depends_on 'gtk3' => :build
  depends_on 'libevdev' => :library
  depends_on 'libunwind' => :build
  depends_on 'libwacom' => :library
  depends_on 'mtdev' => :library
  depends_on 'valgrind' => :build

  # If debug-gui feature is required, uncomment following lines and remove "-Ddebug-gui=false" to enable it

  meson_options '-Ddebug-gui=false \
      -Ddocumentation=false'
end
