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
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.19.0-2_x86_64/wayland-1.19.0-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '387c4a312b12b4866e49f0f3871359c397817f23ee8796f660d98b1d8945109c'
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
