require 'buildsystems/cmake'

class Webkit2gtk_4_1 < CMake
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  version '2.50.0'
  license 'LGPL-2+ and BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{version.split('-').first}.tar.xz"
  source_sha256 'e564b8099f9a3ae32409539b290bbd2ad084e99b6d22d4aac5e51e4554df8bc2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c220476148a9b263f78e1a9dfc95562bcf8635fbcc403f2c461bbbf7b5f465f',
     armv7l: '6c220476148a9b263f78e1a9dfc95562bcf8635fbcc403f2c461bbbf7b5f465f',
     x86_64: 'fef9f543b22ea521cca9c2e411e279db11e5894d738eb1ee4c75d8673ad1a4ff'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'dav1d' => :build
  depends_on 'enchant' # R
  depends_on 'expat' # R
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hyphen' # R
  depends_on 'icu4c' # R
  depends_on 'lcms' # R
  depends_on 'libavif' # R
  depends_on 'libbacktrace' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libnotify'
  depends_on 'libpng' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
  depends_on 'libtasn1' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'mesa' # R
  depends_on 'pango' # R
  depends_on 'py3_gi_docgen' => :build
  depends_on 'py3_smartypants' => :build
  depends_on 'sqlite' # R
  depends_on 'sysprof' => :build
  depends_on 'unifdef' => :build
  depends_on 'valgrind' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland' # R
  depends_on 'woff2' # R
  depends_on 'zlib' # R

  no_env_options
  no_lto

  def self.patch
    system "sed -i 's,/usr/bin,/usr/local/bin,g' Source/JavaScriptCore/inspector/scripts/codegen/preprocess.pl"
    # This only works in the container.
    system "sudo ln -sf #{CREW_PREFIX}/bin/gcc /usr/bin/gcc" if CREW_IN_CONTAINER
    system "sudo ln -sf #{CREW_PREFIX}/bin/g++ /usr/bin/g++" if CREW_IN_CONTAINER
    if ARCH == 'armv7l'
      # https://www2.webkit.org/show_bug.cgi?id=299166
      # https://www2.webkit.org/attachment.cgi?id=476800
      downloader 'https://www2.webkit.org/attachment.cgi?id=476800', 'c5d82f64fe5d576585d8f57b30ee18702abebbd9bd3eb51e07605d26667a1957', 'armv7l.patch'
      system 'patch -Np2 -i armv7l.patch'
      @arch_flags = '-mfloat-abi=hard -mtls-dialect=gnu -mthumb -mfpu=vfpv3-d16 -mlibarch=armv7-a+fp -march=armv7-a+fp'
      @new_gcc = <<~NEW_GCCEOF
        #!/bin/bash
        gcc #{@arch_flags} $@
      NEW_GCCEOF
      @new_gpp = <<~NEW_GPPEOF
        #!/bin/bash
        # See https://wiki.debian.org/ReduceBuildMemoryOverhead
        g++ #{@arch_flags} --param ggc-min-expand=10 $@
      NEW_GPPEOF
      FileUtils.mkdir_p 'bin'
      File.write('bin/gcc', @new_gcc)
      FileUtils.chmod 0o755, 'bin/gcc'
      File.write('bin/g++', @new_gpp)
      FileUtils.chmod 0o755, 'bin/g++'
    end
  end

  pre_cmake_options "CC=#{CREW_PREFIX}/bin/gcc CXX=#{CREW_PREFIX}/bin/g++"
  cmake_options "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
          -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
          -DENABLE_DOCUMENTATION=OFF \
          -DENABLE_GAMEPAD=OFF \
          -DENABLE_JOURNALD_LOG=OFF \
          -DENABLE_MINIBROWSER=ON \
          -DENABLE_SPEECH_SYNTHESIS=OFF \
          -DPORT=GTK \
          -DPYTHON_EXECUTABLE=`which python` \
          -DUSER_AGENT_BRANDING='Chromebrew' \
          -DUSE_GTK4=OFF \
          -DUSE_JPEGXL=ON \
          -DUSE_SOUP2=OFF"

  if ARCH == 'armv7l'
    def self.build
      # This builds webkit2gtk4_1 (which uses gtk3, but not libsoup2)
      @workdir = Dir.pwd
      # Bubblewrap sandbox breaks on epiphany with
      # bwrap: Can't make symlink at /var/run: File exists
      # LDFLAGS from debian: -Wl,--no-keep-memory
      unless File.file?('build.ninja')
        @arch_linker_flags = ARCH == 'x86_64' ? '' : '-Wl,--no-keep-memory'
        system "CC='#{@workdir}/bin/gcc' CXX='#{@workdir}/bin/g++' CREW_LINKER_FLAGS='#{@arch_linker_flags}' \
          cmake -B builddir -G Ninja \
          #{CREW_CMAKE_OPTIONS.sub('-pipe', '-pipe -Wno-error').gsub('-flto=auto', '').sub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE', '')} \
          -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
          -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
          -DENABLE_DOCUMENTATION=OFF \
          -DENABLE_GAMEPAD=OFF \
          -DENABLE_JOURNALD_LOG=OFF \
          -DENABLE_MINIBROWSER=ON \
          -DENABLE_SPEECH_SYNTHESIS=OFF \
          -DPORT=GTK \
          -DPYTHON_EXECUTABLE=`which python` \
          -DUSER_AGENT_BRANDING='Chromebrew' \
          -DUSE_GTK4=OFF \
          -DUSE_JPEGXL=ON \
          -DUSE_SOUP2=OFF"
      end
      Kernel.system "#{CREW_NINJA} -C builddir -j #{CREW_NPROC}"
      #@counter = 1
      #@counter_max = 20
      #loop do
        #break if Kernel.system "#{CREW_NINJA} -C builddir -j #{CREW_NPROC}"

        #puts "Make iteration #{@counter} of #{@counter_max}...".orange

        #@counter += 1
        #break if @counter > @counter_max
      #end
    end
  end

  cmake_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver", "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver_4.1"
  end
end
