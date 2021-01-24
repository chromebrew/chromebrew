require 'package'

class Berry < Package
  description 'Healthy, bite-sized window manager'
  homepage 'https://github.com/JLErvin/berry'
  version '0.1.5'
  compatibility 'all'
  source_url 'https://github.com/JLErvin/berry/archive/0.1.5.tar.gz'
  source_sha256 '3d2fa52aeba6ed05d3cc0e8308604c5a83e94a8623f3e66ed53fd5e0fdabfabf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/berry-0.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/berry-0.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/berry-0.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/berry-0.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cec62b31daf5040990846378b214c0856b590a9cf84873cb5f44c67a90382bc1',
     armv7l: 'cec62b31daf5040990846378b214c0856b590a9cf84873cb5f44c67a90382bc1',
       i686: 'ed7257e3a11a68f3e21b2546d55bed20364df8d08522a008b002452e784b5f9d',
     x86_64: '68c0aef9dc4654a7abb36c1bbe3a0a9d213840f8f847a21ea40658f7fc56a28e',
  })

  depends_on 'libx11'
  depends_on 'freetype'
  depends_on 'sommelier'

  def self.patch
    #system "touch ./cross.patch"
    puts "Making Patch file".lightred
    system "cat << 'EOF' > cross.patch
diff config.mk.orig config.mk -u
--- config.mk.orig	2020-08-17 19:22:12.659998356 -0400
+++ config.mk	2020-08-17 19:23:12.059998341 -0400
@@ -12,8 +12,8 @@
 PREFIX = /usr/local
 MANPREFIX = ${PREFIX}/share/man

-X11INC = /usr/X11R6/include
-X11LIB = /usr/X11R6/lib
+X11INC = /usr/local/include
+X11LIB = /usr/local/lib

 # Xinerama, comment if you don't want it
 XINERAMALIBS  = -lXinerama
@@ -21,7 +21,7 @@

 # freetype
 FREETYPELIBS = -lfontconfig -lXft
-FREETYPEINC = /usr/include/freetype2
+FREETYPEINC = /usr/local/include/freetype2
 # OpenBSD (uncomment)
 #FREETYPEINC = ${X11INC}/freetype2

@@ -36,7 +36,7 @@
 # flags
 CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=2 -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS} ${DEBUG_CPPFLAGS}
 #CFLAGS   = -g -std=c99 -pedantic -Wall -O0 ${INCS} ${CPPFLAGS} ${DEBUG_CFLAGS}
-CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Os ${INCS} ${CPPFLAGS} ${DEBUG_CFLAGS} $(NAME_DEFINES)
+CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Os ${INCS} ${CPPFLAGS} ${DEBUG_CFLAGS}
 LDFLAGS  = ${LIBS}

 # Solaris
@@ -44,4 +44,4 @@
 #LDFLAGS = ${LIBS}

 # compiler and linker
-CC = cc
+#CC = cc

EOF"
    puts "Patching...".red
    system "cat ./cross.patch"
    system "patch -Np0 < cross.patch"
    puts "Patched!".lightblue
  end
  def self.build
    system "make"
  end
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install PREFIX=#{CREW_PREFIX}"
  end
  def self.postinstall
    puts 'A hoykey system such as sxhkd is needed in order to use berry as a WM'.lightblue
  end
end

