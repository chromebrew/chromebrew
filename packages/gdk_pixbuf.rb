require 'buildsystems/meson'

class Gdk_pixbuf < Meson
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://gtk.org'
  version '2.44.7'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gdk-pixbuf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '445eeb3dd09483cf0a92a11d21f6c4d620ad2b3e9d69b8273208fe3e2cdef028',
     armv7l: '445eeb3dd09483cf0a92a11d21f6c4d620ad2b3e9d69b8273208fe3e2cdef028',
     x86_64: '4f99ec231c3a10501a788e5c499d2736919c5760fd471e340e3109a39642387a'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
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
