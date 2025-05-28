require 'buildsystems/autotools'

class Wxwidgets30 < Autotools
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.5.1-3'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36c5a091e95ffe14411f2039e48b8b37d96098c2826a5d17809b15b0170a9ae6',
     armv7l: '36c5a091e95ffe14411f2039e48b8b37d96098c2826a5d17809b15b0170a9ae6',
     x86_64: '997fd1b8018057234a32d1f320712caf85dd712e871fb5283be3a265abfa78b1'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' => :build
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libnotify' # R
  depends_on 'libsdl' => :build
  depends_on 'libsecret' => :build
  depends_on 'libsm' # R
  depends_on 'libsoup2' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxxf86vm' # R
  depends_on 'pango' # R
  depends_on 'webkit2gtk_4' # R
  depends_on 'zlib' # R

  def self.preflight
    %w[wxwidgets wxwidgets31].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets30".lightblue
    end
  end

  autotools_configure_options '--with-gtk=3 \
    --with-opengl \
    --enable-unicode \
    --enable-graphics_ctx \
    --enable-mediactrl \
    --enable-webview \
    --with-regex=builtin \
    --with-libpng=builtin \
    --with-libjpeg=sys \
    --with-libtiff=sys \
    --without-gnomevfs \
    --disable-universal \
    --disable-precomp-headers'

  autotools_install_extras do
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-3.0", 'wx-config'
    end
  end
end
