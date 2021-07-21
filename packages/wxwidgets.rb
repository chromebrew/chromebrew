require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  @_ver = '3.0.5.1'
  version @_ver + '-3'
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/wxWidgets/wxWidgets.git'
  git_hashtag 'v' + @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets/3.0.5.1-3_armv7l/wxwidgets-3.0.5.1-3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets/3.0.5.1-3_armv7l/wxwidgets-3.0.5.1-3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wxwidgets/3.0.5.1-3_x86_64/wxwidgets-3.0.5.1-3-chromeos-x86_64.tpxz',
  })
  binary_sha256({
    aarch64: 'f2409c1a97f926a1fcb21ef7f5217a361c06389f9044a764cab20b5a8a721343',
     armv7l: 'f2409c1a97f926a1fcb21ef7f5217a361c06389f9044a764cab20b5a8a721343',
     x86_64: 'fef36327456b2b3fe3aa73af54a028aef85bbd9e312f5ddce5954a8eb3900a22',
  })

  depends_on 'gst_plugins_base'
  depends_on 'libnotify'
  depends_on 'libsdl'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'mesa'
  depends_on 'gtk3'

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
    IO.write('make-abicheck-non-fatal.patch', @make_abicheck_non_fatal_patch)
    system 'patch -p1 -i make-abicheck-non-fatal.patch || true'
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
      --with-libpng=sys \
      --with-libjpeg=sys \
      --with-libtiff=sys \
      --without-gnomevfs \
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
