require 'buildsystems/meson'

class Wayland < Meson
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version "1.23.1-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6f79f1d26cf93d9effaa46756a2319f4ca8680e02cb23d897d08a9b84c63c6a',
     armv7l: 'b6f79f1d26cf93d9effaa46756a2319f4ca8680e02cb23d897d08a9b84c63c6a',
       i686: 'a0a324eea67718aeffa1fcd050626088cafffd02bd24e1b5f111cdc2f54bc48e',
     x86_64: 'c53a3cc2c8bad1f6c49a7f0c4865d9493522611012bcb66ef9bd0dec333f8030'
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
