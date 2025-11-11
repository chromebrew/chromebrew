require 'buildsystems/meson'

class Rest < Meson
  description 'Helper library for RESTful services'
  homepage 'https://wiki.gnome.org/Projects/Librest'
  version '0.10.2'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/librest.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a9b4bbfdab731111905178f1a64e37a82efc5f56c035cdc9d58a663353001399',
     armv7l: 'a9b4bbfdab731111905178f1a64e37a82efc5f56c035cdc9d58a663353001399',
     x86_64: 'b88b209c54bf4d5fea21d1b3cd014e65917490adac68948481c4d313d576780d'
  })

  unless ancestors[0].to_s.split('::')[1].downcase == 'gtk3'
    depends_on 'gtk4' # Keep the gtk4 dependency from being pulled in during a gtk3 build.
  end
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'gtksourceview_5' => :build
  depends_on 'json_glib' # R
  depends_on 'librsvg' => :build
  depends_on 'libsoup' # R
  depends_on 'libxml2' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'py3_toml' => :build
  depends_on 'py3_typogrify' => :build
  depends_on 'vulkan_headers' => :build

  gnome

  meson_options '-D{examples,gtk_doc,soup2,tests}=false'
end
