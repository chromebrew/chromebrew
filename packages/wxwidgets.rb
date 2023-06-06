require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  @_ver = '3.2.2.1'
  version @_ver
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets/3.2.2.1_armv7l/wxwidgets-3.2.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets/3.2.2.1_armv7l/wxwidgets-3.2.2.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets/3.2.2.1_x86_64/wxwidgets-3.2.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5df8dca7225732f859f585e4092305d9fb903c7809eb0e7e0909db544b0ee863',
     armv7l: '5df8dca7225732f859f585e4092305d9fb903c7809eb0e7e0909db544b0ee863',
     x86_64: 'b06a5b45fb34594dcbb9cc1010ce7604627946e71701ce89ed6128f5ea5195d4'
  })

  depends_on 'at_spi2_core' # R
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
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libnotify' # R
  depends_on 'libpng' # R
  depends_on 'libsdl' => :build
  depends_on 'libsdl2' # R
  depends_on 'libsecret' # R
  depends_on 'libsm' # R
  depends_on 'libsoup2' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxtst' # R
  depends_on 'libxxf86vm' # R
  depends_on 'mesa' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4' # R
  depends_on 'zlibpkg' # R

  no_env_options

  def self.preflight
    %w[wxwidgets30 wxwidgets31].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets".lightblue
    end
  end

  def self.build
    system "cmake -B builddir -G Ninja \
     #{CREW_CMAKE_OPTIONS.gsub('mold', 'gold')}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-3.2", 'wx-config'
    end
  end
end
