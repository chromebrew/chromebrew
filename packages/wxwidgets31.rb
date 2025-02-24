require 'buildsystems/autotools'

class Wxwidgets31 < Autotools
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.1.7-3'
  license 'wxWindows Library Licence'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16716d1f62fbdb4f67173a3938d06f27f0a2dd8d30e70c240cd3ea13519b31ba',
     armv7l: '16716d1f62fbdb4f67173a3938d06f27f0a2dd8d30e70c240cd3ea13519b31ba',
     x86_64: '1346e7b16a2f7583adfa16242e7068a5a0b6d1a0b61ff8fb7a3915bfccdb70d3'
  })

  # cmake builds are broken on this versiondue due to an OpenGL
  # detection error in cmake
  # https://gitlab.kitware.com/cmake/cmake/-/issues/24019
  # https://github.com/wxWidgets/wxWidgets/issues/22841

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'enchant' # R
  depends_on 'expat' # R
  depends_on 'fontconfig' # R
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
  depends_on 'jbigkit' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg_turbo' # R
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
  depends_on 'zlib' # R

  def self.preflight
    %w[wxwidgets wxwidgets30].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets31".lightblue
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
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-3.1", 'wx-config'
    end
  end
end
