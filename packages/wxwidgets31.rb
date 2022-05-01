require 'package'

class Wxwidgets31 < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  @_ver = '3.1.6'
  version @_ver
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.6_armv7l/wxwidgets31-3.1.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.6_armv7l/wxwidgets31-3.1.6-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets31/3.1.6_x86_64/wxwidgets31-3.1.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ec00c1f8cefea8fe50d8926bf1f4a077b2adebc35005aa929c0a2c5bb6334cf7',
     armv7l: 'ec00c1f8cefea8fe50d8926bf1f4a077b2adebc35005aa929c0a2c5bb6334cf7',
     x86_64: 'e1b739eb3e7253fa5741226fae1d1fb9de9fcd7f75e3fd93f7bedfb0f17ed4eb'
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

  def self.patch
    # Keeps an abicheck error from derailing compile on multiple versions of wxwidgets, including 3.1
    # This may be useful when moving to the next 3.1 based stable version, so keep it in.
    @make_abicheck_non_fatal_patch = <<~'PATCH_EOF'
      diff -up wxGTK-2.8.12/src/common/appbase.cpp.abicheck wxGTK-2.8.12/src/common/appbase.cpp
      --- wxGTK-2.8.12/src/common/appbase.cpp.abicheck	2015-03-12 17:15:18.000000000 +0100
      +++ wxGTK-2.8.12/src/common/appbase.cpp	2015-03-12 17:15:57.000000000 +0100
      @@ -424,10 +424,7 @@ bool wxAppConsole::CheckBuildOptions(con
               msg.Printf(_T("Mismatch between the program and library build versions detected.\nThe library used %s,\nand %s used %s."),
                          lib.c_str(), progName.c_str(), prog.c_str());
       
      -        wxLogFatalError(msg.c_str());
      -
      -        // normally wxLogFatalError doesn't return
      -        return false;
      +        wxLogWarning(msg.c_str());
           }
       #undef wxCMP
    PATCH_EOF
    File.write('make-abicheck-non-fatal.patch', @make_abicheck_non_fatal_patch)
    system 'patch -p1 -i make-abicheck-non-fatal.patch || true'
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
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
