require 'package'

class Gdk_pixbuf < Package
  description 'GdkPixbuf is a library for image loading and manipulation.'
  homepage 'https://developer.gnome.org/gdk-pixbuf'
  @_ver = '2.42.6'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gdk-pixbuf.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6_armv7l/gdk_pixbuf-2.42.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6_armv7l/gdk_pixbuf-2.42.6-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6_i686/gdk_pixbuf-2.42.6-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdk_pixbuf/2.42.6_x86_64/gdk_pixbuf-2.42.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e34b1d8685646cfcf999bb84c699e19c749d6cefd9d5346702bf8bc611293234',
     armv7l: 'e34b1d8685646cfcf999bb84c699e19c749d6cefd9d5346702bf8bc611293234',
       i686: 'e96ec7db0611cc7701754b3466b4b1d337123a62eefd06be0976254482b50027',
     x86_64: '275ea5531916a62aa263e2f94c3eeb23af85140dfc4034ed513c044ad2277d6f'
  })

  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'jasper' => :build
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
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
    system "meson #{CREW_MESON_OPTIONS} \
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
    system "env GDK_PIXBUF_MODULEDIR=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders \
      GDK_PIXBUF_MODULE_FILE=#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache \
      LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} gdk-pixbuf-query-loaders --update-cache"
  end
end
