require 'package'

class Libinput < Package
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput'
  @_ver = '1.19.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.2_armv7l/libinput-1.19.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.2_armv7l/libinput-1.19.2-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.2_x86_64/libinput-1.19.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f0bfc3ddddb5d34e874cb9b02bccda660f8600051ffdbdebe60760adfa427f3b',
     armv7l: 'f0bfc3ddddb5d34e874cb9b02bccda660f8600051ffdbdebe60760adfa427f3b',
     x86_64: '3d1a343fecb4cedf97f176a3be8ecdb80b8166d45f65fb97142e6fd91f7b3391'
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
