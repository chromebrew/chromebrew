require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.5.1-1'
  compatibility 'all'
  source_url 'https://github.com/wxWidgets/wxWidgets/archive/v3.0.5.1.tar.gz'
  source_sha256 'bae4d9f289e33a05fb8553fcc580564d30efe6a882ff08e3d4e09ef01f5f6578'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6831092ab33fdc4c10df52bdc779652f26f8d7c8a1e48097768a3892eea164f7',
      armv7l: '6831092ab33fdc4c10df52bdc779652f26f8d7c8a1e48097768a3892eea164f7',
        i686: '71f57c87fb5f1256a811e241ecc8db54a6042d4a9941128b09fff1e3192a8fa7',
      x86_64: '04c515d5f4280c78e50ac0e79577f862ef3d526473e096e6ee8f731f43055135',
  })

  depends_on 'gst_plugins_base'
  depends_on 'libnotify'
  depends_on 'libsdl'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'mesa'
  depends_on 'gtk3'

  def self.build
    # Keeps an abicheck error from derailing compile on multiple versions of wxwidgets, including 3.1
    # This may be useful when moving to the next 3.1 based stable version, so keep it in.
    system "cat <<'EOF'> make-abicheck-non-fatal.patch
diff -up wxGTK-2.8.12/src/common/appbase.cpp.abicheck wxGTK-2.8.12/src/common/appbase.cpp
--- wxGTK-2.8.12/src/common/appbase.cpp.abicheck	2015-03-12 17:15:18.000000000 +0100
+++ wxGTK-2.8.12/src/common/appbase.cpp	2015-03-12 17:15:57.000000000 +0100
@@ -424,10 +424,7 @@ bool wxAppConsole::CheckBuildOptions(con
         msg.Printf(_T(\"Mismatch between the program and library build versions detected.\nThe library used %s,\nand %s used %s.\"),
                    lib.c_str(), progName.c_str(), prog.c_str());

-        wxLogFatalError(msg.c_str());
-
-        // normally wxLogFatalError doesn't return
-        return false;
+        wxLogWarning(msg.c_str());
     }
 #undef wxCMP
EOF"
    system "patch -Np1 -i make-abicheck-non-fatal.patch || true"
    system "./configure --help"
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS} \
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
  end
end
