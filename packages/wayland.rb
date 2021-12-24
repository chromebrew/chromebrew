require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.20.0'
  version @_ver
  compatibility 'all'
  license 'MIT'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0_armv7l/wayland-1.20.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0_armv7l/wayland-1.20.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0_i686/wayland-1.20.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0_x86_64/wayland-1.20.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '459023ef9fb5fa1df1b9f3fa315b7d47c5466108d34fae3c0a94ed818a65ab88',
     armv7l: '459023ef9fb5fa1df1b9f3fa315b7d47c5466108d34fae3c0a94ed818a65ab88',
       i686: '73cac6d8b4dbcb585563925821c786122b3e770ba8cc8189c7085617bf5d565a',
     x86_64: 'bced326d7fa76850e0c4314fcd9bad02ecc5ff9a5a53451f7ca4b7b1bb3d11a2'
  })

  depends_on 'expat'
  depends_on 'libpng'
  depends_on 'libxslt'

  def self.build
    @env = <<~EOF
      # environment set-up for Chrome OS built-in Wayland server
      set -a
      # all variables will export automatically
      XDG_RUNTIME_DIR=/var/run/chrome
      XDG_SESSION_TYPE=wayland
      WAYLAND_DISPLAY=wayland-0
      CLUTTER_BACKEND=wayland
      GDK_BACKEND=wayland
      set +a
    EOF

    system "meson #{CREW_MESON_FNO_LTO_OPTIONS} \
    -Ddocumentation=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/env.d/")
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/wayland", @env)
  end
end
