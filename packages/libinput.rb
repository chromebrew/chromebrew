require 'package'

class Libinput < Package
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput'
  @_ver = '1.19.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/libinput/libinput-#{@_ver}.tar.xz"
  source_sha256 '3d3a2f12b4a65cd82684121ae4b33cdc3ad541c761a55e8eb73a8e5e443cccbb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.0_armv7l/libinput-1.19.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.0_armv7l/libinput-1.19.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.0_x86_64/libinput-1.19.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '92d7106871145a7b83c4fcf91603563473de4da33c4b3368b4a795a7e51629e1',
     armv7l: '92d7106871145a7b83c4fcf91603563473de4da33c4b3368b4a795a7e51629e1',
     x86_64: '46bdc13b4d3e214591300759ec62d14d76e20faa9d8f05f887f88e1cd70cac62'
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
    system "meson #{CREW_MESON_OPTIONS} \
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
