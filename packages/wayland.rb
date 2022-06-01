require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.20.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0-1_armv7l/wayland-1.20.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0-1_armv7l/wayland-1.20.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0-1_i686/wayland-1.20.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland/1.20.0-1_x86_64/wayland-1.20.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '62b00aaca85d9915fe016b8d12e0bb4dcfd5c96ed25284ce0a72eb3807149fb8',
     armv7l: '62b00aaca85d9915fe016b8d12e0bb4dcfd5c96ed25284ce0a72eb3807149fb8',
       i686: 'b4996e1d41e80fce12418356ed63a5b4090eabd71a5edf1aab014a75f023f422',
     x86_64: '1123fd65e1ec4d681d0f6e19cbcecbc121b65888f75e1fbdcc70263b5fcc22ed'
  })

  depends_on 'expat'
  depends_on 'libxml2'
  depends_on 'gcc'
  depends_on 'icu4c'
  depends_on 'zlibpkg'
  depends_on 'libffi'

  def self.build
    @wayland_env = <<~WAYLAND_ENV_EOF
      # environment set-up for Chrome OS built-in Wayland server
      set -a

      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
    WAYLAND_ENV_EOF

    system "meson #{CREW_MESON_OPTIONS} -Ddocumentation=false builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/env.d/")
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/wayland", @wayland_env)
  end
end
