require 'package'

class Libinput < Package
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput/'
  version '1.21.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c131c07fb1f1d4e9a59a47b30cfa53c7b0a9f746a35091c1576cf822a5b58637',
     armv7l: 'c131c07fb1f1d4e9a59a47b30cfa53c7b0a9f746a35091c1576cf822a5b58637',
     x86_64: 'c7961df2596c843e5822b2ac94c0d88ffc126bf9fdf3a3a6c985b8997a3fa789'
  })

  depends_on 'mtdev'
  depends_on 'libevdev'
  depends_on 'libwacom'
  depends_on 'libunwind'
  depends_on 'libcheck'
  depends_on 'valgrind' => :build

  # If debug-gui feature is required, uncomment following lines and remove "-Ddebug-gui=false" to enable it
  # depends_on 'graphviz' => :build
  # depends_on 'gtk3' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Ddebug-gui=false \
      -Ddocumentation=false \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
