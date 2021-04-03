require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  @_ver = '2.42.4'
  version "#{@_ver}-1"
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/#{@_ver}/gdk-pixbuf-#{@_ver}.tar.bz2"
  source_sha256 'd94d2e67165739559a6323a23eea8ad3560ab1085e2a3356a19548c9cb88e1e9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdk_pixbuf-2.42.4-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '62e8a794241bbeb7e4699617aa77dbae0e4ff7498ffac640a0ddeb09c66c0e92',
     armv7l: '62e8a794241bbeb7e4699617aa77dbae0e4ff7498ffac640a0ddeb09c66c0e92',
       i686: '2906220e700f765463aa12e2ca7b6500a92cdbae49f752470860fcc432986849',
     x86_64: '6eefc5ee6bd5d37334e5745bff55eb240933d7751ad7eb0a78bdd965c3c50a90'
  })

  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'jasper' => :build
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp' => :build
  depends_on 'pango' => :build
  depends_on 'six' => :build

  @python_deps = %w[Markdown typogrify]

  def self.prebuild
    @python_deps.each do |item|
      system "pip install --upgrade #{item}"
    end
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Dinstalled_tests=false \
      -Dbuiltin_loaders=all \
      -Drelocatable=true \
      -Djasper=true \
      -Ddebug=false \
      -Dman=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
    @python_deps.each do |item|
      system "pip uninstall --yes #{item}"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
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
    ENV['GDK_PIXBUF_MODULEDIR'] = "#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders"
    ENV['GDK_PIXBUF_MODULE_FILE'] = "#{ENV['GDK_PIXBUF_MODULEDIR']}.cache"
    system 'gdk-pixbuf-query-loaders --update-cache'
  end
end
