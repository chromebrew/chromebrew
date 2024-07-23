require 'buildsystems/meson'

class Wayland < Meson
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.23.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a38b96e747ebfd1cb9c753a87cbbc567009632297dbec4229873d028601088e',
     armv7l: '6a38b96e747ebfd1cb9c753a87cbbc567009632297dbec4229873d028601088e',
       i686: '21f052811fb6e2452166068fdd7d67230ecc18251e2997be1c37f940d1638dae',
     x86_64: 'ffc57b3964206380f16b74b5a562458e035c5c60ab3a64db29c6951653c4f4fe'
  })

  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' => :build
  depends_on 'libffi' # R
  depends_on 'libxml2' # R
  depends_on 'zlibpkg' => :build

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
