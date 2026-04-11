require 'buildsystems/meson'

class Libgedit_gfls < Meson
  description 'A module dedicated to file loading and saving.'
  homepage 'https://gitlab.gnome.org/World/gedit/libgedit-gfls'
  version '0.4.1'
  license 'LGPL-3.0-or-later'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-gfls.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7397976d4bfff41124ed32a733995a8b96c9000bec5dcb466b06e8e4ee6ce1fb',
     armv7l: '7397976d4bfff41124ed32a733995a8b96c9000bec5dcb466b06e8e4ee6ce1fb',
     x86_64: 'af2ba9397cc3c8e01ab9245c816bf74314c187b390a7be44ec1b3b110601e4c0'
  })

  depends_on 'glib' => :library
  depends_on 'glib_stub' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection'
  depends_on 'gtk3'

  meson_options '-Dgtk_doc=false'
end
