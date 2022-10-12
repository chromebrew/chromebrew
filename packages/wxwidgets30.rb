require 'package'

class Wxwidgets30 < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.5.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{version}"

  binary_url({
    x86_64: 'file:///home/chronos/user/chromebrew/release/x86_64/wxwidgets30-3.0.5.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '152777e14b5faa3256f04fd5df463887c3d348b537ab9bbfa10b8e92ec0a040d'
  })

  depends_on 'atk' # R
  depends_on 'fontconfig'
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libglu' # R
  depends_on 'libjpeg' # R
  depends_on 'libnotify' # R
  depends_on 'libsdl'
  depends_on 'libsecret'
  depends_on 'libsm' # R
  depends_on 'libsoup'
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxxf86vm' # R
  depends_on 'mesa' # R
  depends_on 'pango' # R

  def self.preflight
    %w[wxwidgets wxwidgets31].each do |wxw|
      if File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"
        puts "#{wxw} installed and conflicts with this version.".orange
        puts "To install this version, execute the following:".lightblue
        abort "crew remove #{wxw} && crew install wxwidgets30".lightblue
      end
    end
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --with-gtk=3 \
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
      --disable-precomp-headers"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-3.0", 'wx-config'
    end
  end
end
