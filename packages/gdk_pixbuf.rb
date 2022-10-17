require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  @_ver = '2.42.9'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gdk-pixbuf.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.9-1_armv7l/gdk_pixbuf-2.42.9-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.9-1_armv7l/gdk_pixbuf-2.42.9-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.9-1_i686/gdk_pixbuf-2.42.9-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.9-1_x86_64/gdk_pixbuf-2.42.9-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e52abe3bc1922618fda217215f5defef83f40b6cbe21737f50ed653ee9001d4a',
     armv7l: 'e52abe3bc1922618fda217215f5defef83f40b6cbe21737f50ed653ee9001d4a',
       i686: '47693eb2d34477b97ccb6cd29ab50890dcb383d19bd30b4ac60a606a0ddc77d2',
     x86_64: '72f1a9e8c7f3e3c44aed7b21a07ad7f200207c1f0c759be2622e999c92b4b1df'
  })

  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libjpeg' # R
  # depends_on 'libtiff' # R This drags gtk3 into the deps via libwebp
  # depends_on 'libwebp' => :build This drags gtk3 into the deps.
  depends_on 'pango' => :build
  depends_on 'py3_docutils' => :build
  depends_on 'py3_jinja2' => :build
  depends_on 'py3_markdown' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_toml' => :build
  depends_on 'py3_typogrify' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Drelocatable=true \
      -Ddebug=false \
      -Dgtk_doc=false \
      -Dman=true \
      builddir"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    loader_dir = "#{CREW_DEST_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    FileUtils.mkdir_p loader_dir
    system "touch #{loader_dir}.cache"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @gdk_pixbuf_env = <<~GDK_PIXBUF_ENV_EOF
      # gdk-pixbuf configuration
      export GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders
      export GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache
    GDK_PIXBUF_ENV_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/gdk_pixbuf", @gdk_pixbuf_env)
  end

  def self.postinstall
    system "env GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders \
      GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache \
      LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} gdk-pixbuf-query-loaders --update-cache"
  end
end
