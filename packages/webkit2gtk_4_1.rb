require 'package'

class Webkit2gtk_4_1 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  version '2.44.2'
  license 'LGPL-2+ and BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.37'
  source_url 'https://webkitgtk.org/releases/webkitgtk-2.44.2.tar.xz'
  source_sha256 '523f42c8ff24832add17631f6eaafe8f9303afe316ef1a7e1844b952a7f7521b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f97d19d647d8eac60b30cc6306cf20ab1154ac074707f84491c9bb319c2cb743',
     armv7l: 'f97d19d647d8eac60b30cc6306cf20ab1154ac074707f84491c9bb319c2cb743',
     x86_64: 'd55485064d6bfb73475ea96186970bc1552c766b0717a5a2ab951dfe8bf6b687'
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
  depends_on 'glibc_lib' # R
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
  depends_on 'libgpgerror' # R
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
  depends_on 'zlibpkg' # R

  no_env_options

  def self.patch
    system "sed -i 's,/usr/bin,/usr/local/bin,g' Source/JavaScriptCore/inspector/scripts/codegen/preprocess.pl"
    @arch_flags = ''
    @gcc_ver = ''
    if ARCH == 'armv7l' || ARCH == 'aarch64'
      @arch_flags = '-mfloat-abi=hard -mtls-dialect=gnu -mthumb -mfpu=vfpv3-d16 -mlibarch=armv7-a+fp -march=armv7-a+fp'
    end
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
          #{CREW_CMAKE_FNO_LTO_OPTIONS.sub('-pipe', '-pipe -Wno-error').gsub('-fno-lto', '')} \
          -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
          -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
          -DENABLE_DOCUMENTATION=OFF \
          -DENABLE_GLES2=OFF \
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
      break if Kernel.system "mold -run #{CREW_NINJA} -C builddir -j #{CREW_NPROC}"

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
