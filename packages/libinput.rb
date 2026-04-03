require 'buildsystems/meson'

class Libinput < Meson
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput/'
  version '1.31.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '078e2baf38e7e14c1d72c099def8689b6d086108165835de4477acd54095cffe',
     armv7l: '078e2baf38e7e14c1d72c099def8689b6d086108165835de4477acd54095cffe',
     x86_64: 'b060fb0bd1edec4e07854a59debed3ff34b26e2c38dba228b7e9276d7fa94dfb'
  })

  depends_on 'check' => :build
  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
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
