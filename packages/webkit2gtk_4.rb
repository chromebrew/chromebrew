class Webkit2gtk_4 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.36.8'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.36.8.tar.xz'
  source_sha256 '0ad9fb6bf28308fe3889faf184bd179d13ac1b46835d2136edbab2c133d00437'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.32.4_armv7l/webkit2gtk_4-2.32.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.32.4_armv7l/webkit2gtk_4-2.32.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.36.8_i686/webkit2gtk_4-2.36.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.36.8_x86_64/webkit2gtk_4-2.36.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd25a0be821cbf2c710539e685268d47bdcde109ed5a18b2202c132b31b341219',
     armv7l: 'd25a0be821cbf2c710539e685268d47bdcde109ed5a18b2202c132b31b341219',
       i686: 'd40ff5b6f346fbab7178f355b649c49548453d1c9fd56dee9f1cba84825646e9',
     x86_64: '9501da66dcc415a799dff35cdc25f9fe7149a8d08f662e1f9fe680e2ddfcf11d'
  })

  depends_on 'atk'
  depends_on 'cairo'
  # depends_on 'ccache' => :build
  depends_on 'dav1d'
  depends_on 'enchant'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer'
  depends_on 'gtk3'
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
  depends_on 'libglvnd' # R

  no_env_options

  def self.patch
    system "sed -i 's,/usr/bin,/usr/local/bin,g' Source/JavaScriptCore/inspector/scripts/codegen/preprocess.pl"
    return unless ARCH == 'armv7l' || ARCH == 'aarch64'

    # Patch from https://bugs.webkit.org/show_bug.cgi?id=226557#c27 to
    # handle issue with gcc > 11.
    @gcc_patch = <<~'GCCEOF'
      diff --git a/Source/cmake/WebKitCompilerFlags.cmake b/Source/cmake/WebKitCompilerFlags.cmake
      index 77ebb802ebb03450b5e96629a47b6819a68672c6..d49d6e43d7eeb6673c624e00eadf3edfca0674eb 100644
      --- a/Source/cmake/WebKitCompilerFlags.cmake
      +++ b/Source/cmake/WebKitCompilerFlags.cmake
      @@ -143,6 +143,13 @@ if (COMPILER_IS_GCC_OR_CLANG)
               WEBKIT_PREPEND_GLOBAL_CXX_FLAGS(-Wno-nonnull)
           endif ()

      +    # This triggers warnings in wtf/Packed.h, a header that is included in many places. It does not
      +    # respect ignore warning pragmas and we cannot easily suppress it for all affected files.
      +    # https://bugs.webkit.org/show_bug.cgi?id=226557
      +    if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND ${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER_EQUAL "11.0")
      +        WEBKIT_PREPEND_GLOBAL_CXX_FLAGS(-Wno-stringop-overread)
      +    endif ()
      +
           # -Wexpansion-to-defined produces false positives with GCC but not Clang
           # https://bugs.webkit.org/show_bug.cgi?id=167643#c13
           if (CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    GCCEOF
    File.write('gcc.patch', @gcc_patch)
    system 'patch -Np1 -F 10 -i gcc.patch'
    # Patch from https://github.com/WebKit/WebKit/pull/1233
    downloader 'https://patch-diff.githubusercontent.com/raw/WebKit/WebKit/pull/1233.diff',
               '70c990ced72c5551b01c9d7c72da7900d609d0f7891e7b99ab132ac1b4aa33ea'
    system 'patch -Np1 -F 10 -i 1233.diff'
    ## Maybe ARM_NEON isn't being detected properly in containers.
    system "sed -i 's,#if CPU(ARM_NEON) && CPU(ARM_TRADITIONAL) && COMPILER(GCC_COMPATIBLE),#if COMPILER(GCC_COMPATIBLE),g' Source/WebCore/platform/graphics/filters/software/FELightingSoftwareApplier.h",
exception: false
    # system "sed -i 's,#if CPU(ARM_NEON) && CPU(ARM_TRADITIONAL) && COMPILER(GCC_COMPATIBLE),#if COMPILER(GCC_COMPATIBLE),g' Source/WebCore/platform/graphics/filters/FELighting.h",
    # exception: false
    # system "sed -i 's,data.pixels->bytes(),data.pixels->data(),g' Source/WebCore/platform/graphics/cpu/arm/filters/FELightingNEON.h",
    # exception: false
    # system 'grep GCC_COMPATIBLE Source/WebCore/platform/graphics/filters/FELighting.h'
  end

  def self.build
    @force_32bit = ARCH == 'x86_64' ? 'OFF' : 'ON'
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
          -DUSE_GTK4=OFF \
          -DUSE_SOUP2=ON \
          -DUSE_AVIF=ON \
          -DPYTHON_EXECUTABLE=`which python` \
          -DUSER_AGENT_BRANDING='Chromebrew' \
          -DFORCE_32BIT=#{@force_32bit} \
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
