require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  @_ver = '3.2.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{@_ver}"

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
  depends_on 'webkit2gtk_4'
  depends_on 'expat' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libcurl' # R
  depends_on 'libice' # R
  depends_on 'libpng' # R
  depends_on 'libsdl2' # R
  depends_on 'libsoup2' # R
  depends_on 'libxext' # R
  depends_on 'libxtst' # R
  depends_on 'pcre2' # R
  depends_on 'wayland' # R
  depends_on 'zlibpkg' # R

  def self.preflight
    %w[wxwidgets30 wxwidgets31].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets".lightblue
    end
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-3.2", 'wx-config'
    end
  end
end
