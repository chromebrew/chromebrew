require 'package'

class Wxwidgets31 < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.1.7'
  compatibility 'all'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.7_armv7l/wxwidgets31-3.1.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.7_armv7l/wxwidgets31-3.1.7-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.7_x86_64/wxwidgets31-3.1.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ce03b99f4b8ff0ddf623ab3063f239835730c15e4eb7a96d8d0da34215ea8f0c',
     armv7l: 'ce03b99f4b8ff0ddf623ab3063f239835730c15e4eb7a96d8d0da34215ea8f0c',
     x86_64: '297db664625538bdae60759b35cd6e57e6424a902b8ddacab3375eeda189b547'
  })

  depends_on 'atk' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3'
  depends_on 'gvfs'
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
  depends_on 'mesa'
  depends_on 'pango' # R

  def self.preflight
    %w[wxwidgets wxwidgets30].each do |wxw|
      if File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"
        puts "#{wxw} installed and conficts with this version.".orange
        puts "To install this version, execute the following:".lightblue
        abort "crew remove #{wxw} && crew install wxwidgets31".lightblue
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
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-3.1", 'wx-config'
    end
  end
end
