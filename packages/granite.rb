require 'buildsystems/meson'

class Granite < Meson
  description 'Library that extends GTK with common widgets and utilities'
  homepage 'https://github.com/elementary/granite'
  version '7.8.1'
  license 'LGPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/elementary/granite.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4df2afcd696818545b8eb47d705a12a2834a4462444ad4bfaff0a92873f2327a',
     armv7l: '4df2afcd696818545b8eb47d705a12a2834a4462444ad4bfaff0a92873f2327a',
     x86_64: '48b2de2162231337492a3f917ecdb7656fbbf130a77ecdd8c32a1367b3ae7780'
  })

  gnome

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'gsettings_desktop_schemas' => :executable
  depends_on 'gtk3' => :library
  depends_on 'gtk4' => :library
  depends_on 'libgee' => :library
  depends_on 'libshumate' => :executable
  depends_on 'pango' => :library
  depends_on 'py3_meson' => :build
  depends_on 'sassc' => :library
  depends_on 'vala' => :library
end
