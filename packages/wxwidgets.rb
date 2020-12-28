require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.5.1'
  compatibility 'all'
  source_url 'https://github.com/wxWidgets/wxWidgets/archive/v3.0.5.1.tar.gz'
  source_sha256 'bae4d9f289e33a05fb8553fcc580564d30efe6a882ff08e3d4e09ef01f5f6578'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wxwidgets-3.0.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '440d312b479a90ffd73e84c396b9d54a76a01f8049adb820535236845b8b2acb',
      armv7l: '440d312b479a90ffd73e84c396b9d54a76a01f8049adb820535236845b8b2acb',
        i686: 'aed2e2b7577f820dcb2f6eddaa39b6b602d47249b5dc8f5d0b2b18c6093b9c30',
      x86_64: '3e3df3560a084dfe8e100728ae77ebcb68548186e05d7c787d162e015d71245c',
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
    system "unset CC CXX CXXFLAGS CFLAGS && \
      export LIBRARY_PATH=#{CREW_LIB_PREFIX} && \
      export LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} && \
      export CC=gcc && \
      export CXX=g++ && \
      export CFLAGS= && \
      ./configure #{CREW_OPTIONS} \
      --with-gtk=3 --with-opengl --enable-unicode \
      --enable-graphics_ctx --enable-mediactrl --enable-webview --with-regex=builtin \
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
