require 'package'

class Wxwidgets31 < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  @_ver = '3.1.7'
  version "#{@_ver}-2"
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.7-2_armv7l/wxwidgets31-3.1.7-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.7-2_armv7l/wxwidgets31-3.1.7-2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.7-2_x86_64/wxwidgets31-3.1.7-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '642d5fa6f174b88d332cf1bf6b975e2c40d3dae860797a6f85d1e719fc9daa6e',
     armv7l: '642d5fa6f174b88d332cf1bf6b975e2c40d3dae860797a6f85d1e719fc9daa6e',
     x86_64: '858111828f9238cf899ecb8d38996de584566184ad42702c7dddea081dae6932'
  })

  # cmake builds are broken on this versiondue due to an OpenGL
  # detection error in cmake
  # https://gitlab.kitware.com/cmake/cmake/-/issues/24019
  # https://github.com/wxWidgets/wxWidgets/issues/22841

  depends_on 'at_spi2_core' # R
  depends_on 'curl' # R
  depends_on 'enchant' # R
  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gspell' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'gvfs' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg' # R
  depends_on 'libnotify' # R
  depends_on 'libsdl' => :build
  depends_on 'libsecret' # R
  depends_on 'libsm' # R
  depends_on 'libsoup2' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxtst' # R
  depends_on 'libxxf86vm' # R
  depends_on 'mesa' => :build
  depends_on 'pango' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4' # R
  depends_on 'zlibpkg' # R

  def self.preflight
    %w[wxwidgets wxwidgets30].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets31".lightblue
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
