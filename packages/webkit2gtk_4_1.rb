class Webkit2gtk_4_1 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  version '2.38.0'
  compatibility 'all'
  license 'LGPL-2+ and BSD-2'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.38.0.tar.xz'
  source_sha256 'f9ce6375a3b6e1329b0b609f46921e2627dc7ad6224b37b967ab2ea643bc0fbd'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4_1/2.38.0_x86_64/webkit2gtk_4_1-2.38.0-chromeos-x86_64.tar.zst',
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4_1/2.38.0_i686/webkit2gtk_4_1-2.38.0-chromeos-i686.tar.zst'
  })
  binary_sha256({
    x86_64: 'f2257d44deabad8866fe43a7e7ebc3b44af28e9fe1cd8df9353a04b3dd2ff07e',
      i686: 'aad673c3561f317633ab7e1910cc65d9df4b6f32cf1ff43e5930328fc96bb142'
  })

  depends_on 'atk' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo'
  depends_on 'ccache' => :build
  depends_on 'dav1d'
  depends_on 'enchant' # R
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hyphen' # R
  depends_on 'icu4c' # R
  depends_on 'lcms' # R
  depends_on 'libavif' # R
  depends_on 'libgcrypt' # R
  depends_on 'libglvnd' # R
  depends_on 'libgpgerror' # R
  depends_on 'libjpeg' # R
  depends_on 'libjxl' # R
  depends_on 'libnotify'
  depends_on 'libpng' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup'
  depends_on 'libsoup2' # R
  depends_on 'libtasn1' # R
  depends_on 'libwebp' # R
  depends_on 'libwpe' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxdamage' # R
  depends_on 'libxml2' # R
  depends_on 'libxrender' # R
  depends_on 'libxslt' # R
  depends_on 'libxt' # R
  depends_on 'mesa' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'sqlite' # R
  depends_on 'valgrind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland' # R
  depends_on 'woff2' # R
  depends_on 'wpebackend_fdo' # R
  depends_on 'zlibpkg' # R

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
  end

  def self.build
    # This builds webkit2gtk4 (which uses gtk3)
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # Bubblewrap sandbox breaks on epiphany with
      # bwrap: Can't make symlink at /var/run: File exists
      system "mold -run cmake \
          -G Ninja \
          #{CREW_CMAKE_FNO_LTO_OPTIONS.sub('-pipe', '-pipe -Wno-error').gsub('-fno-lto', '')} \
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
          -DUSE_SOUP2=OFF \
          -DUSE_AVIF=ON \
          -DPYTHON_EXECUTABLE=`which python` \
          -DUSER_AGENT_BRANDING='Chromebrew' \
          .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system 'DESTDIR=/usr/local/tmp/crew/dest ninja -C builddir install'
  end
end
