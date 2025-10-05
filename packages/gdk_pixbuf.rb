require 'buildsystems/meson'

class Gdk_pixbuf < Meson
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  version '2.44.3'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gdk-pixbuf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d79852a5069b1c1e5a6834648c32f346ad407e894be2ecc75a66f69cf42160c',
     armv7l: '8d79852a5069b1c1e5a6834648c32f346ad407e894be2ecc75a66f69cf42160c',
     x86_64: '65eb125c9b4a15ba85b5f3d95f7e5a66d1024154ed34cf807d8fa651800e259d'
  })

  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'pango' => :build
  depends_on 'py3_docutils' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_jinja2' => :build
  depends_on 'py3_markdown' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_toml' => :build
  depends_on 'py3_typogrify' => :build
  depends_on 'glibc' # R
  depends_on 'libpng' # R
  depends_on 'zlib' # R

  gnome

 meson_options '-Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Drelocatable=true \
      -Ddebug=false \
      -Dgtk_doc=false \
      -Dman=true \
      -Dtests=false'

  meson_install_extras do
    loader_dir = "#{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    FileUtils.mkdir_p loader_dir
    system "touch #{loader_dir}.cache"

    File.write 'gdk_pixbuf_env.d', <<~GDK_PIXBUF_ENV_EOF
      # gdk-pixbuf configuration
      export GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders
      export GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache
    GDK_PIXBUF_ENV_EOF
    FileUtils.install 'gdk_pixbuf_env.d', "#{CREW_DEST_PREFIX}/etc/env.d/gdk_pixbuf", mode: 0o644
  end
end
