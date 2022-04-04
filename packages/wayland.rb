require 'package'

class Wayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  @_ver = '1.20.0'
  version @_ver + '-1'
  compatibility 'all'
  license 'MIT'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag @_ver

  depends_on 'expat'
  depends_on 'libpng'
  depends_on 'libxslt'

  def self.build
    @env = <<~EOF
      # environment set-up for Chrome OS built-in Wayland server
      set -a

      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
    EOF

    system "meson #{CREW_MESON_OPTIONS} -Ddocumentation=false builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/env.d/")
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/wayland", @env)
  end
end
