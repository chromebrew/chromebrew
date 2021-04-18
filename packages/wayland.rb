require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.19.0'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url "https://wayland.freedesktop.org/releases/wayland-#{@_ver}.tar.xz"
  source_sha256 'baccd902300d354581cd5ad3cc49daa4921d55fb416a5883e218750fef166d15'

  depends_on 'expat'
  depends_on 'libpng'
  depends_on 'libffi'
  depends_on 'libxml2'
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
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/env.d/")
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/wayland", @env)
  end
end
