require 'buildsystems/meson'

class Wayland < Meson
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version "1.26.0-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70cfa63042bf1a1193c4a2856521832be32c872c14ea798a492fd4e2f8447ee0',
     armv7l: '70cfa63042bf1a1193c4a2856521832be32c872c14ea798a492fd4e2f8447ee0',
       i686: 'c113962111edda89a97b2596e0f8da021b782ab5991667c4014e6b11103c85d7',
     x86_64: 'c824e204aae45133d30e445811037956bbdac56414631d3c9e1d0b869426e38c'
  })

  depends_on 'expat' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'icu4c' => :build
  depends_on 'libffi' => :library
  depends_on 'libxml2' => :executable
  depends_on 'zlib' => :build

  meson_options '-Ddocumentation=false'
  meson_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/wayland", <<~WAYLAND_ENV_EOF, perms: 0o644
      # environment set-up for Chrome OS built-in Wayland server
      : "${XDG_RUNTIME_DIR:=/var/run/chrome}"
      : "${XDG_SESSION_TYPE:=wayland}"
      : "${WAYLAND_DISPLAY:=wayland-0}"
      : "${CLUTTER_BACKEND:=wayland}"
      : "${GDK_BACKEND:=wayland}"
    WAYLAND_ENV_EOF
  end
end
