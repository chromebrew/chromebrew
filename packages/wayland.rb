require 'buildsystems/meson'

class Wayland < Meson
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.23.0-icu75.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00866e69c544d72ba85c3345ff2c1704f7764da2fecb740a5cca93d8f7b6b886',
     armv7l: '00866e69c544d72ba85c3345ff2c1704f7764da2fecb740a5cca93d8f7b6b886',
       i686: '19a50a7d696f6ef4bac35ce845b6ec5b15ce31bcd593bfd5a192509871cd8f92',
     x86_64: 'b55d4d2c9dfcf2fafac5bf7c5cbc395de8fa057bb7bc748c906116cb4a4e5a81'
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
