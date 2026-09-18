require 'buildsystems/meson'

class Libinput < Meson
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput/'
  version '1.32.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f88da7c89004f014f95217cc7f27fae382c4eb39281434597647a1a52032e04',
     armv7l: '9f88da7c89004f014f95217cc7f27fae382c4eb39281434597647a1a52032e04',
     x86_64: '1d09d6d5ac362f02980a5dcc50fbf9d1ea330c42b3aa1c150deb506fa0f4486e'
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
