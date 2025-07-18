require 'buildsystems/meson'

class Wayland < Meson
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version "1.24.0-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df1340d2a03d08c198d1118f7b66708f51b6c5b044a48b7a5717fdbb8aac6508',
     armv7l: 'df1340d2a03d08c198d1118f7b66708f51b6c5b044a48b7a5717fdbb8aac6508',
       i686: '31a5cbf3d9a2494d76227a17b6dfa352c85a2d0a26136b24caed17dd7c0f9d41',
     x86_64: 'b715939c3e527dd0badbc4623714710cd9b8988c8ab5b1c50b7afdb64c3f399f'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' => :build
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'zlib' => :build

  meson_options '-Ddocumentation=false'

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    File.write 'waylandenv', <<~WAYLAND_ENV_EOF
      # environment set-up for Chrome OS built-in Wayland server
      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
    WAYLAND_ENV_EOF
    FileUtils.install 'waylandenv', "#{CREW_DEST_PREFIX}/etc/env.d/wayland", mode: 0o644
  end
end
