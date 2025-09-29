require 'package'

class Webkit2gtk_4_1 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  version "2.44.3-#{CREW_ICU_VER}"
  license 'LGPL-2+ and BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.44.3.tar.xz'
  source_sha256 'dc82d042ecaca981a4852357c06e5235743319cf10a94cd36ad41b97883a0b54'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c220476148a9b263f78e1a9dfc95562bcf8635fbcc403f2c461bbbf7b5f465f',
     armv7l: '6c220476148a9b263f78e1a9dfc95562bcf8635fbcc403f2c461bbbf7b5f465f',
     x86_64: '80b969a2d1a82d55852f5026aefac336c8092d8d8c3628450e7fb1a47121e3de'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'ccache' => :build
  depends_on 'dav1d' => :build
  depends_on 'enchant' # R
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
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
  depends_on 'libbacktrace' # R
  depends_on 'libdrm' # R
  depends_on 'libepoxy' # R
  depends_on 'libgcrypt' # R
  depends_on 'libglvnd' # R
  depends_on 'libgpg_error' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libjxl' # R
  depends_on 'libnotify'
  depends_on 'libpng' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup' # R
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
  depends_on 'unifdef' => :build
  depends_on 'valgrind' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland' # R
  depends_on 'woff2' # R
  depends_on 'wpebackend_fdo' # R
  depends_on 'zlib' # R

  no_env_options

  def self.patch
    # Fix incompatibility with gtk3 from current gobjects_introspection causing build failure
    # as per https://bugs.webkit.org/show_bug.cgi?id=276180 .
    downloader 'https://github.com/WebKit/WebKit/pull/30446.diff', '6beda7960b232117f8445db4e588a45ef384d42ccb13f6926b695c472a4eea51'
    system 'patch -Np1 -i 30446.diff'
    system "sed -i 's,/usr/bin,/usr/local/bin,g' Source/JavaScriptCore/inspector/scripts/codegen/preprocess.pl"
    @arch_flags = ''
    @gcc_ver = ''
    @arch_flags = '-mfloat-abi=hard -mtls-dialect=gnu -mthumb -mfpu=vfpv3-d16 -mlibarch=armv7-a+fp -march=armv7-a+fp' if ARCH == 'armv7l' || ARCH == 'aarch64'
  end

  def self.build
    # This builds webkit2gtk4_1 (which uses gtk3, but not libsoup2)
    @workdir = Dir.pwd
    # Bubblewrap sandbox breaks on epiphany with
    # bwrap: Can't make symlink at /var/run: File exists
    # LDFLAGS from debian: -Wl,--no-keep-memory
    unless File.file?('build.ninja')
      @arch_linker_flags = ARCH == 'x86_64' ? '' : '-Wl,--no-keep-memory'
      system "CREW_LINKER_FLAGS='#{@arch_linker_flags}' \
          cmake -B builddir -G Ninja \
          #{CREW_CMAKE_OPTIONS.sub('-pipe', '-pipe -Wno-error').gsub('-flto=auto', '').sub('-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE', '')} \
          -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
          -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
          -DENABLE_DOCUMENTATION=OFF \
          -DENABLE_JOURNALD_LOG=OFF \
          -DENABLE_GAMEPAD=OFF \
          -DENABLE_MINIBROWSER=ON \
          -DUSE_SYSTEM_MALLOC=ON \
          -DPORT=GTK \
          -DUSE_GTK4=OFF \
          -DUSE_JPEGXL=ON \
          -DUSE_SOUP2=OFF \
          -DPYTHON_EXECUTABLE=`which python` \
          -DUSER_AGENT_BRANDING='Chromebrew'"
    end
    @counter = 1
    @counter_max = 20
    loop do
      break if Kernel.system "#{CREW_NINJA} -C builddir -j #{CREW_NPROC}"

      puts "Make iteration #{@counter} of #{@counter_max}...".orange

      @counter += 1
      break if @counter > @counter_max
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver", "#{CREW_DEST_PREFIX}/bin/WebKitWebDriver_4.1"
  end
end
