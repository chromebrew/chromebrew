require 'buildsystems/autotools'

class Wxwidgets < Autotools
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.2.6-1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '105a793c38cc606b4d476e2b4063f4ba41a0f84fb70e87cfd09e7f438eb2e98c',
     armv7l: '105a793c38cc606b4d476e2b4063f4ba41a0f84fb70e87cfd09e7f438eb2e98c',
     x86_64: '680f76b00098a9fc6206b19ce967f9e6b32f2c4460aa6ee8971e074ba9e6b0e1'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'enchant' # R
  depends_on 'expat' # R
  depends_on 'fontconfig'
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gspell' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'jbigkit' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libnotify' # R
  depends_on 'libpng' # R
  depends_on 'libsdl2' # R
  depends_on 'libsdl' => :build
  depends_on 'libsecret' # R
  depends_on 'libsm' # R
  depends_on 'libsoup2' # R
  depends_on 'libsoup' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxtst' # R
  depends_on 'libxxf86vm' # R
  depends_on 'mesa' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'zlib' # R

  def self.preflight
    %w[wxwidgets30 wxwidgets31].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets".lightblue
    end
  end

  configure_options '--with-gtk=3 \
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
    --disable-precomp-headers'

  configure_install_extras do
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-3.2", 'wx-config'
    end
  end
end
