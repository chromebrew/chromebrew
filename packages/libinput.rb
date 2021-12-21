require 'package'

class Libinput < Package
  description 'libinput is a library to handle input devices in Wayland compositors and to provide a generic X.Org input driver.'
  homepage 'https://www.freedesktop.org/wiki/Software/libinput'
  @_ver = '1.19.2'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/libinput/libinput.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.2-1_armv7l/libinput-1.19.2-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.2-1_armv7l/libinput-1.19.2-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.2-1_i686/libinput-1.19.2-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libinput/1.19.2-1_x86_64/libinput-1.19.2-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e05b75fc7ce64fb075f80c166f040e44f93348ed9a1498edf62eca9bf6a63453',
     armv7l: 'e05b75fc7ce64fb075f80c166f040e44f93348ed9a1498edf62eca9bf6a63453',
       i686: '6abab518091907420a19b90b858dacf2179f70b9c75b66c2727fa13d0143430e',
     x86_64: 'b0c906ccc338b8b675d75d9c9845f569c3a1735fbe35e602c6a669a997f4f950'
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
