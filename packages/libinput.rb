require 'package'

class Libinput < Package
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput'
  @_ver = '1.17.0'
  version @_ver
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/libinput/libinput-#{@_ver}.tar.xz"
  source_sha256 'c560cfca14cb5c50d2a1b7551df06bc5d4306e32c128f3e3d37e137285dedbad'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.17.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.17.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.17.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libinput-1.17.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a449ec4b3a457cf1222606c053bd90d6ff857434f06fdce33689d2bc198f2280',
     armv7l: 'a449ec4b3a457cf1222606c053bd90d6ff857434f06fdce33689d2bc198f2280',
       i686: '3b5cd49e73d1351369a4afd268a5bb84dc1a6ac00a0381fc9d94b89e753ca7c1',
     x86_64: '7f4ed0a79f83c740aa1c708accf6f483b00345507df91a4d164117cd5bbb498e'
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
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Ddebug-gui=false \
      -Ddocumentation=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
