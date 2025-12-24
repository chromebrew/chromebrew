require 'buildsystems/cmake'

class Wxwidgets < CMake
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.3.1-1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/wxWidgets/wxWidgets/releases/download/v#{version.split('-')[0]}/wxWidgets-#{version.split('-')[0]}.tar.bz2"
  source_sha256 'f936c8d694f9c49a367a376f99c751467150a4ed7cbf8f4723ef19b2d2d9998d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9b9c9eb0e30a906bd2a80bcde9a43c7fe0588e9763f2f040d9dc42591e68805',
     armv7l: 'e9b9c9eb0e30a906bd2a80bcde9a43c7fe0588e9763f2f040d9dc42591e68805',
     x86_64: '407295bab738f459f781999b51215142fcdf73dfc67118276d6299e04b1946ab'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'fontconfig'
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gspell' # R
  depends_on 'gstreamer' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libmspack' # R
  depends_on 'libnotify' # R
  depends_on 'libpng' # R
  depends_on 'libsdl' => :build
  depends_on 'libsm' # R
  depends_on 'libsoup' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxtst' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'sdl2' # R
  depends_on 'wayland' # R
  depends_on 'webkit2gtk_4_1' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  def self.preflight
    %w[wxwidgets30 wxwidgets31].each do |wxw|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{wxw}.filelist"

      puts "#{wxw} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{wxw} && crew install wxwidgets".lightblue
    end
  end

  def self.patch
    patches = [
      # Fix for build failure
      ['https://github.com/wxWidgets/wxWidgets/commit/666f7489bb2ffbd8298069393a90ddbe18221df5.patch', 'bf775dbba0da0627386ce51e771dba114c7ec35d5c45c759da7d0d4aebf00c8f']
    ]
    ConvenienceFunctions.patch(patches)
  end

  cmake_options "-DwxBUILD_TOOLKIT=gtk3 \
    -DwxUSE_OPENGL=ON \
    -DwxUSE_REGEX=sys\
    -DwxUSE_ZLIB=sys \
    -DwxUSE_EXPAT=sys \
    -DwxUSE_LIBJPEG=sys \
    -DwxUSE_LIBPNG=sys \
    -DwxUSE_LIBTIFF=sys \
    -DwxUSE_LIBLZMA=sys \
    -DwxUSE_NANOSVG=sys \
    -DwxUSE_LIBMSPACK=ON \
    -DwxUSE_PRIVATE_FONTS=ON \
    -DwxUSE_GTKPRINT=ON \
    -DwxUSE_STD_STRING_CONV_IN_WXSTRING=ON \
    -DwxUSE_WEBVIEW=ON"

  cmake_install_extras do
    # Fixes CMake Warning:
    #   Manually-specified variables were not used by the project:
    #
    #     CMAKE_INSTALL_LIBDIR
    if ARCH.eql?('x86_64')
      Dir["#{CREW_DEST_PREFIX}/lib/**/*"].each do |lib|
        lib64 = lib.sub("#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX)
        if File.directory?(lib)
          FileUtils.mkdir_p lib64
        else
          FileUtils.mv lib, lib64
        end
      end
    end
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-#{version.split('-')[0].sub(/\.\d+$/, '')}", "#{CREW_DEST_PREFIX}/bin/wx-config"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/wxrc-#{version.split('-')[0].sub(/\.\d+$/, '')}", "#{CREW_DEST_PREFIX}/bin/wxrc"
  end
end
