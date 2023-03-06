class Webkit2gtk_4_1 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  version '2.38.3'
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.38.3.tar.xz'
  source_sha256 '41f001d1ed448c6936b394a9f20e4640eebf83a7f08262df28504f7410604a5a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4_1/2.38.3_armv7l/webkit2gtk_4_1-2.38.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4_1/2.38.3_armv7l/webkit2gtk_4_1-2.38.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4_1/2.38.3_i686/webkit2gtk_4_1-2.38.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4_1/2.38.3_x86_64/webkit2gtk_4_1-2.38.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e8cb89f4b9af14a04f4ec01d3d8b43c4a2dee3da4a468d99729fbd0532b78de4',
     armv7l: 'e8cb89f4b9af14a04f4ec01d3d8b43c4a2dee3da4a468d99729fbd0532b78de4',
       i686: 'd5f26338fce98085a4e5638bac8f5b29fd73c092e1c9c9ae5be82e80f1f352c5',
     x86_64: '915161e70db53e313b65f234733a5bda433e0fd192672062a1c737e7a345e2f4'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo'
  # depends_on 'ccache' => :build
  depends_on 'dav1d'
  depends_on 'enchant' # R
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc10' => :build if %w[aarch64 armv7l i686].include? ARCH
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
    @arch_flags = ''
    @gcc_ver = ''
    if ARCH == 'armv7l' || ARCH == 'aarch64'
      ## Patch from https://bugs.webkit.org/show_bug.cgi?id=226557#c27 to
      ## handle issue with gcc > 11.
      # @gcc_patch = <<~'GCCEOF'
      # diff --git a/Source/cmake/WebKitCompilerFlags.cmake b/Source/cmake/WebKitCompilerFlags.cmake
      # index 77ebb802ebb03450b5e96629a47b6819a68672c6..d49d6e43d7eeb6673c624e00eadf3edfca0674eb 100644
      #--- a/Source/cmake/WebKitCompilerFlags.cmake
      #+++ b/Source/cmake/WebKitCompilerFlags.cmake
      # @@ -143,6 +143,13 @@ if (COMPILER_IS_GCC_OR_CLANG)
      # WEBKIT_PREPEND_GLOBAL_CXX_FLAGS(-Wno-nonnull)
      # endif ()

      #+    # This triggers warnings in wtf/Packed.h, a header that is included in many places. It does not
      #+    # respect ignore warning pragmas and we cannot easily suppress it for all affected files.
      #+    # https://bugs.webkit.org/show_bug.cgi?id=226557
      #+    if (CMAKE_CXX_COMPILER_ID MATCHES "GNU" AND ${CMAKE_CXX_COMPILER_VERSION} VERSION_GREATER_EQUAL "11.0")
      #+        WEBKIT_PREPEND_GLOBAL_CXX_FLAGS(-Wno-stringop-overread)
      #+    endif ()
      #+
      ## -Wexpansion-to-defined produces false positives with GCC but not Clang
      ## https://bugs.webkit.org/show_bug.cgi?id=167643#c13
      # if (CMAKE_CXX_COMPILER_ID MATCHES "GNU")
      # GCCEOF
      # File.write('gcc.patch', @gcc_patch)
      # system 'patch -Np1 -F 10 -i gcc.patch'
      # Patch from https://github.com/WebKit/WebKit/pull/1233
      # downloader 'https://patch-diff.githubusercontent.com/raw/WebKit/WebKit/pull/1233.diff',
      #           '70c990ced72c5551b01c9d7c72da7900d609d0f7891e7b99ab132ac1b4aa33ea'
      # system "sed -i 's,data.pixels->bytes(),data.pixels->data(),' 1233.diff"
      # system 'patch -Np1 -F 10 -i 1233.diff'
      # Patch from https://github.com/WebKit/WebKit/pull/2926
      # downloader 'https://patch-diff.githubusercontent.com/raw/WebKit/WebKit/pull/2926.diff',
      # '26a8d5a9dd9d61865645158681b766e13cf05b3ed07f30bebb79ff73259d0664'
      # system "sed -i '22,63d' 2926.diff"
      # system 'patch -Np1 -F 10 -i 2926.diff'
      # @arch_flags = '-mtune=cortex-a15 -mfloat-abi=hard -mfpu=neon -mtls-dialect=gnu -marm -mlibarch=armv8-a+crc+simd -march=armv8-a+crc+simd'
      @arch_flags = '-mfloat-abi=hard -mtls-dialect=gnu -mthumb -mfpu=vfpv3-d16 -mlibarch=armv7-a+fp -march=armv7-a+fp'
    end
    @gcc_ver = '-10' if %w[aarch64 armv7l i686].include? ARCH
    @new_gcc = <<~NEW_GCCEOF
      #!/bin/bash
      gcc#{@gcc_ver} #{@arch_flags} $@
    NEW_GCCEOF
    @new_gpp = <<~NEW_GPPEOF
      #!/bin/bash
      g++#{@gcc_ver} #{@arch_flags} $@
    NEW_GPPEOF
    FileUtils.mkdir_p 'bin'
    File.write('bin/gcc', @new_gcc)
    FileUtils.chmod 0o755, 'bin/gcc'
    File.write('bin/g++', @new_gpp)
    FileUtils.chmod 0o755, 'bin/g++'
  end

  def self.build
    # This builds webkit2gtk4 (which uses gtk3)
    FileUtils.mkdir_p 'builddir'
    @workdir = `pwd`.chomp
    Dir.chdir 'builddir' do
      # Bubblewrap sandbox breaks on epiphany with
      # bwrap: Can't make symlink at /var/run: File exists
      # LDFLAGS from debian: -Wl,--no-keep-memory
      unless File.file?('build.ninja')
        @arch_linker_flags = ARCH == 'x86_64' ? '' : '-Wl,--no-keep-memory'
        system "CREW_LINKER_FLAGS='#{@arch_linker_flags}' CC='#{@workdir}/bin/gcc' CXX='#{@workdir}/bin/g++' cmake \
            -G Ninja \
            #{CREW_CMAKE_FNO_LTO_OPTIONS.gsub('mold', 'gold').sub('-pipe', '-pipe -Wno-error').gsub('-fno-lto', '')} \
            -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
            -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
            -DENABLE_DOCUMENTATION=OFF \
            -DENABLE_JOURNALD_LOG=OFF \
            -DENABLE_GAMEPAD=OFF \
            -DENABLE_MINIBROWSER=ON \
            -DUSE_SYSTEM_MALLOC=ON \
            -DPORT=GTK \
            -DUSE_GTK4=OFF \
            -DUSE_SOUP2=OFF \
            -DPYTHON_EXECUTABLE=`which python` \
            -DUSER_AGENT_BRANDING='Chromebrew' \
            .."
      end
      system "ninja -j #{CREW_NPROC} || ninja -j #{CREW_NPROC.to_f.fdiv(2).ceil} || ninja -j #{CREW_NPROC.to_f.fdiv(2).ceil} || ninja -j #{CREW_NPROC.to_f.fdiv(3).ceil} || ninja -j #{CREW_NPROC.to_f.fdiv(4).ceil}"
    end
  end

  def self.install
    system 'DESTDIR=/usr/local/tmp/crew/dest ninja -C builddir install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver", "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver_4.1"
  end
end
