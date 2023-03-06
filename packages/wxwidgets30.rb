require 'package'

class Wxwidgets30 < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  @_ver = '3.0.5.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets30/3.0.5.1-1_armv7l/wxwidgets30-3.0.5.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets30/3.0.5.1-1_armv7l/wxwidgets30-3.0.5.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets30/3.0.5.1-1_i686/wxwidgets30-3.0.5.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets30/3.0.5.1-1_x86_64/wxwidgets30-3.0.5.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8068d9a249b50137533460cc3526617c277cf0e4fbce2ab405266146f4129031',
     armv7l: '8068d9a249b50137533460cc3526617c277cf0e4fbce2ab405266146f4129031',
       i686: 'df2a33b55203e2aaac28edf186f557a25225f0da4496f5922bb0de6d45526619',
     x86_64: '0eb2ecba4109d960ab9c23a51161964b26864aad475f7d2a2bfc63b3b4a1a8da'
  })

  depends_on 'atk_spi2_core' # R
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
  depends_on 'webkit2gtk_4'
  depends_on 'expat' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libsoup2' # R
  depends_on 'zlibpkg' # R

  def self.preflight
    %w[wxwidgets wxwidgets31].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets30".lightblue
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
