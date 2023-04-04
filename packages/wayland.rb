require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.22.0'
  version @_ver
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.22.0_armv7l/wayland-1.22.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.22.0_armv7l/wayland-1.22.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.22.0_x86_64/wayland-1.22.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '78e0b1c7e54a4af3caa20151692bc1370e8925106c1673455bd7e8f12eb380ca',
     armv7l: '78e0b1c7e54a4af3caa20151692bc1370e8925106c1673455bd7e8f12eb380ca',
     x86_64: '757e55aabee653519af9d4b01888ddbb6a4bbb024be79749322f36b2dfbcf636'
  })

  depends_on 'expat' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' => :build
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' => :build

  def self.build
    File.write 'waylandenv', <<~WAYLAND_ENV_EOF
      # environment set-up for Chrome OS built-in Wayland server
      set -a

      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
      set +a
    WAYLAND_ENV_EOF
    system "meson setup #{CREW_MESON_OPTIONS} -Ddocumentation=false builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.install 'waylandenv', "#{CREW_DEST_PREFIX}/etc/env.d/wayland", mode: 0o644
  end
end
