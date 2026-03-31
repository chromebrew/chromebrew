require 'buildsystems/meson'

class Wayland < Meson
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version "1.25.0-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd7d7b8a3293dab8ac9b7daf4bc7d46f88c3a9c863f4f0b75ec85ed0c584afe80',
     armv7l: 'd7d7b8a3293dab8ac9b7daf4bc7d46f88c3a9c863f4f0b75ec85ed0c584afe80',
       i686: '3722084a585711b9dc9785625c257fedbac4c13dea25e3ac91f59616d466858e',
     x86_64: '8c2b17c21815ce678a5a3c4d3d52afd2fde10466a6b60858507a9fc6c5a2b59e'
  })

  depends_on 'expat' => :executable
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
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
