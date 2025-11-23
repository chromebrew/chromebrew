require 'buildsystems/meson'

class Libinput < Meson
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput/'
  version '1.29.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3c9b91070c96b6b8ab1800eae145b044a42eb51ee14a517bf993eda5422e2f6',
     armv7l: 'a3c9b91070c96b6b8ab1800eae145b044a42eb51ee14a517bf993eda5422e2f6',
       i686: '23210fa0f78aef18c64121f7a2ee0c764877a5602743ce614ee6f9f07998cd61',
     x86_64: '470f2ebdae07083c13f2b2c11c4e8e535481e4e972796ff30a5e8a5495db1c2b'
  })

  # depends_on 'graphviz' => :build
  # depends_on 'gtk3' => :build
  depends_on 'check' => :build
  depends_on 'eudev' # R
  depends_on 'glibc' # R
  depends_on 'libevdev' # R
  depends_on 'libunwind' => :build
  depends_on 'libwacom' # R
  depends_on 'libwacom' # R
  depends_on 'mtdev' # R
  depends_on 'valgrind' => :build

  # If debug-gui feature is required, uncomment following lines and remove "-Ddebug-gui=false" to enable it

  meson_options '-Ddebug-gui=false \
      -Ddocumentation=false'
end
