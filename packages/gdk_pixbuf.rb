require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  @_ver = '2.42.4-1'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/#{@_ver}/gdk-pixbuf-#{@_ver}.tar.bz2"
  source_sha256 'd94d2e67165739559a6323a23eea8ad3560ab1085e2a3356a19548c9cb88e1e9'

  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'jasper' => :build
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp' => :build
  depends_on 'pango' => :build
  depends_on 'py3_six' => :build
  depends_on 'py3_markdown' => :build
  depends_on 'py3_typogrify' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Drelocatable=true \
      -Djasper=true \
      -Ddebug=false \
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
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/gdk_pixbuf", @gdk_pixbuf_env)
  end

  def self.postinstall
    system "env GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders \
      GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache \
      gdk-pixbuf-query-loaders --update-cache"
  end
end
