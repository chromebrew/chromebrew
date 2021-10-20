require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.19.0'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://wayland.freedesktop.org/releases/wayland-#{@_ver}.tar.xz"
  source_sha256 'baccd902300d354581cd5ad3cc49daa4921d55fb416a5883e218750fef166d15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.19.0-2_armv7l/wayland-1.19.0-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.19.0-2_armv7l/wayland-1.19.0-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.19.0-2_i686/wayland-1.19.0-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.19.0-2_x86_64/wayland-1.19.0-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9f6c1d28fccf5238fa79b698b9a567dc0690a674eb38321731c21dee9c562a14',
     armv7l: '9f6c1d28fccf5238fa79b698b9a567dc0690a674eb38321731c21dee9c562a14',
       i686: '24e8048e2e55226dd20d4e81186120baac62424fc87e0dbaa4e1aabc44834157',
     x86_64: '3dba84fba4ca31b4cb0989154b292b57e298fe87a057267b63a8fc206f79fd4e'
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
