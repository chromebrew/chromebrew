class Webkit2gtk_5 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.38.0'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.38.0.tar.xz'
  source_sha256 'f9ce6375a3b6e1329b0b609f46921e2627dc7ad6224b37b967ab2ea643bc0fbd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_5/2.32.4_armv7l/webkit2gtk_5-2.32.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_5/2.32.4_armv7l/webkit2gtk_5-2.32.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_5/2.38.0_i686/webkit2gtk_5-2.38.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_5/2.38.0_x86_64/webkit2gtk_5-2.38.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5a4da2ee8bc5889ccf768da845a33f94bf988e626c3af16a3c30f6dcb3584a85',
     armv7l: '5a4da2ee8bc5889ccf768da845a33f94bf988e626c3af16a3c30f6dcb3584a85',
       i686: 'a58c67697d485faa397cf7949a4f188fe92f64d954404683d25cf9ff694c12a5',
     x86_64: '00dfad25dd4195cebf42489122887b197137e17adee3b6b60532d46add743a6c'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'ccache' => :build
  depends_on 'dav1d'
  depends_on 'enchant'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'graphene' # R
  depends_on 'gstreamer'
  depends_on 'gtk4'
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz'
  depends_on 'hyphen'
  depends_on 'icu4c' # R
  depends_on 'lcms' # R
  depends_on 'libavif' # R
  depends_on 'libgcrypt'
  depends_on 'libgpgerror' # R
  depends_on 'libjpeg'
  depends_on 'libjxl'
  depends_on 'libnotify'
  depends_on 'libpng'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'libtasn1' # R
  depends_on 'libwebp'
  depends_on 'libwpe'
  depends_on 'libx11'
  depends_on 'libxcomposite'
  depends_on 'libxdamage'
  depends_on 'libxml2' # R
  depends_on 'libxrender'
  depends_on 'libxslt'
  depends_on 'libxt'
  depends_on 'mesa'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'sqlite' # R
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland'
  depends_on 'woff2'
  depends_on 'wpebackend_fdo'
  depends_on 'zlibpkg' # R

  def self.patch
    system "sed -i 's,/usr/bin,/usr/local/bin,g' Source/JavaScriptCore/inspector/scripts/codegen/preprocess.pl"
    # return unless ARCH == 'armv7l' || ARCH == 'aarch64'

    # downloader 'https://github.com/Igalia/meta-webkit/raw/main/recipes-browser/wpewebkit/wpewebkit/0001-FELightningNEON.cpp-fails-to-build-NEON-fast-path-se.patch',
    #           '85996f657ab01d83424fd74a060c9439c0c1b44bdcfe05772b4c5949eff24fc4'
    # system 'patch -Np1 -i 0001-FELightningNEON.cpp-fails-to-build-NEON-fast-path-se.patch'
  end

  def self.build
    # This builds webkit2gtk4 (which uses gtk3)
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # Bubblewrap sandbox breaks on epiphany with
      # bwrap: Can't make symlink at /var/run: File exists
      # case ARCH
      # when 'x86_64'
      system "mold -run cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DCMAKE_SKIP_RPATH=ON \
          -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
          -DENABLE_JOURNALD_LOG=OFF \
          -DENABLE_GAMEPAD=OFF \
          -DENABLE_GLES2=ON \
          -DENABLE_INTROSPECTION=ON \
          -DENABLE_MINIBROWSER=ON \
          -DENABLE_VIDEO=ON \
          -DENABLE_WAYLAND_TARGET=ON \
          -DENABLE_WEB_AUDIO=OFF \
          -DUSE_WPE_RENDERER=ON \
          -DUSE_JPEGXL=ON \
          -DPORT=GTK \
          -DUSE_GTK4=ON \
          -DUSE_SOUP2=OFF \
          -DUSE_AVIF=ON \
          -DPYTHON_EXECUTABLE=`which python` \
          -DUSER_AGENT_BRANDING='Chromebrew' \
          .."
      # when 'i686', 'armv7l', 'aarch64'
      # system "cmake \
      #-G Ninja \
      # #{CREW_CMAKE_OPTIONS} \
      #-DCMAKE_SKIP_RPATH=ON \
      #-DENABLE_BUBBLEWRAP_SANDBOX=OFF \
      #-DENABLE_JOURNALD_LOG=OFF \
      #-DENABLE_GAMEPAD=OFF \
      #-DENABLE_GLES2=ON \
      #-DENABLE_INTROSPECTION=ON \
      #-DENABLE_MINIBROWSER=ON \
      #-DENABLE_VIDEO=ON \
      #-DENABLE_WAYLAND_TARGET=ON \
      #-DENABLE_WEB_AUDIO=OFF \
      #-DUSE_WPE_RENDERER=ON \
      #-DUSE_JPEGXL=ON \
      #-DPORT=GTK \
      #-DUSE_GTK4=OFF \
      #-DUSE_SOUP2=ON \
      #-DUSE_AVIF=ON \
      #-DPYTHON_EXECUTABLE=`which python` \
      #-DUSER_AGENT_BRANDING='Chromebrew' \
      #-DFORCE_32BIT=ON \
      # .."
      # end
    end
    system 'ninja -C builddir'
  end

  def self.install
    system 'DESTDIR=/usr/local/tmp/crew/dest ninja -C builddir install'
  end
end
