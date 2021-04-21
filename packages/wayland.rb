require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.19.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url "https://wayland.freedesktop.org/releases/wayland-#{@_ver}.tar.xz"
  source_sha256 'baccd902300d354581cd5ad3cc49daa4921d55fb416a5883e218750fef166d15'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/wayland-1.19.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/wayland-1.19.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/wayland-1.19.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/wayland-1.19.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'afde6d47410b47f681cf945f3fee881715d5d67c78e055353011413498fda590',
     armv7l: 'afde6d47410b47f681cf945f3fee881715d5d67c78e055353011413498fda590',
       i686: '460606fc3edcac28c61a684ef1a22fad67ff569d3fdb1f9d7414e4a8dbcbc923',
     x86_64: 'd57e02b79a9e6d875b0496597bab4d219fc257df08bafb0be7dee39cbbd7c597'
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
