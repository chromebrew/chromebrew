require 'buildsystems/meson'

class Gdk_pixbuf < Meson
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://gtk.org'
  version '2.44.5'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gdk-pixbuf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4fbaaed3cd722b5b6c8ff58d074034e843b64ef851551ab993976330075aa68',
     armv7l: 'c4fbaaed3cd722b5b6c8ff58d074034e843b64ef851551ab993976330075aa68',
     x86_64: 'f664583d212dfbebae068e7f636448b1989018416d0571e442d42846780bb856'
  })

  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'pango' => :build
  depends_on 'py3_docutils' => :build
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_jinja2' => :build
  depends_on 'py3_markdown' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_toml' => :build
  depends_on 'py3_typogrify' => :build

  gnome

  meson_options '-Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Dglycin=disabled \
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
