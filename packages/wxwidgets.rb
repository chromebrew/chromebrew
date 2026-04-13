require 'buildsystems/cmake'

class Wxwidgets < CMake
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.3.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71a67c4702c781a8909cfcaa1d2232761a054c6d8c0a18e5e22693bf8cc8dba4',
     armv7l: '71a67c4702c781a8909cfcaa1d2232761a054c6d8c0a18e5e22693bf8cc8dba4',
     x86_64: 'f453b990265a984437373873055e71d78bba0ce92e3e21b1db979634bb7e3b89'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'curl' => :library
  depends_on 'expat' => :library
  depends_on 'fontconfig' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glib_stub' => :library
  depends_on 'glibc' => :library
  depends_on 'gspell' => :library
  depends_on 'gstreamer' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libglu' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libice' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libmspack' => :library
  depends_on 'libnotify' => :library
  depends_on 'libpng' => :library
  depends_on 'libsdl' => :build
  depends_on 'libsm' => :library
  depends_on 'libsoup' => :library
  depends_on 'libtiff' => :library
  depends_on 'libwebp' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxtst' => :library
  depends_on 'nanosvg' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'sdl2' => :library
  depends_on 'sdl2_compat' => :library
  depends_on 'wayland' => :library
  depends_on 'webkit2gtk_4_1' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library

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
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/wx/config/gtk3-unicode-#{version.sub(/\.\d+$/, '')}", "#{CREW_DEST_PREFIX}/bin/wx-config"
    FileUtils.ln_sf "#{CREW_PREFIX}/bin/wxrc-#{version.sub(/\.\d+$/, '')}", "#{CREW_DEST_PREFIX}/bin/wxrc"
  end
end
