require 'buildsystems/meson'

class Rest < Meson
  description 'Helper library for RESTful services'
  homepage 'https://wiki.gnome.org/Projects/Librest'
  version '0.9.1'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librest.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '519192ae5947606899084ab33c89aeffc03e6a21602742a155405dc61bb00c2a',
     armv7l: '519192ae5947606899084ab33c89aeffc03e6a21602742a155405dc61bb00c2a',
     x86_64: 'dcb417551add89f25c24a9f3cdcd3f43c4fa0ac78606775fe252dd6662d3056c'
  })

  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  # Keep the gtk4 dependency from being pulled in during a gtk3 build.
  depends_on 'gtk4' unless ancestors[0].to_s.split('::')[1].downcase == 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_5' => :build
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libadwaita' # R
  depends_on 'librsvg' => :build
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'py3_toml' => :build
  depends_on 'py3_typogrify' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R

  gnome
end
