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
    aarch64: '404183f9b015460fa3834d76a7300ac7659de089625ffcf56a8e043a5aafd77d',
     armv7l: '404183f9b015460fa3834d76a7300ac7659de089625ffcf56a8e043a5aafd77d',
       i686: 'a3ac75e8648f76f6357e115369e1849ee0486b53becd3a98062f84d3b6bf8af0',
     x86_64: '274b8a03df309c7883b3510bb1b36a017f502836c070e22af3e7e2a0184a8a37'
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
