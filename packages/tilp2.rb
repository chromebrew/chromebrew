require 'package'

class Tilp2 < Package
  description 'TiLP 2 is a linking program for Texas Instruments\' graphing calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.18'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/tilp2-1.18.tar.bz2'
  source_sha256 '7b3ab363eeb52504d6ef5811c5d264f8016060bb7bd427be5a064c2ed7384e47'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '201dc44208b9be80c48f7c490db5278734451890fbeb2d2a5d14453edd1fbf38',
     armv7l: '201dc44208b9be80c48f7c490db5278734451890fbeb2d2a5d14453edd1fbf38',
       i686: 'ab237640a29d6b6f5270958be66a85bc149c1e33b3bdffac6cc10e33e5de39b1',
     x86_64: '6299305628afe6455a951234e91a1ee6dc501b48d0f47b1739963080be416536',
  })

  depends_on 'libticalcs2'
  depends_on 'libglade'
  depends_on 'sommelier'

  def self.patch
    system 'cat << _EOF > tilp2.patch
diff -ur a/configure.ac b/configure.ac
--- a/configure.ac	2016-01-15 15:28:52.000000000 -0500
+++ b/configure.ac	2018-09-16 13:15:59.476538177 -0400
@@ -131,7 +131,6 @@
 fi
 if test "x$kde" = "xyes"; then
         AC_PROG_CXX
-        AC_PATH_KDE
         AC_DEFINE(WITH_KDE, 1, [Use KDE support])
 fi
 AM_CONDITIONAL(USE_KDE, test "x$kde" = "xyes")
diff -ur a/src/Makefile.am b/src/Makefile.am
--- a/src/Makefile.am	2016-03-14 15:55:57.000000000 -0400
+++ b/src/Makefile.am	2018-09-16 13:17:01.062539362 -0400
@@ -9,16 +9,13 @@
 tilp_CPPFLAGS = -I$(top_srcdir)/intl \
 	@TICABLES_CFLAGS@ @TIFILES_CFLAGS@ @TICALCS_CFLAGS@ @TICONV_CFLAGS@ \
 	@GLIB_CFLAGS@ @GTK_CFLAGS@ \
-	@KDE_INCLUDES@ @QT_INCLUDES@ \
 	-DSHARE_DIR=\"$(pkgdatadir)\" \
 	-DLOCALEDIR=\"$(datadir)/locale\" \
 	-DSYSCONFDIR=\"$(sysconfdir)\" \
 	-DGTK_DISABLE_DEPRECATED
 tilp_LDFLAGS = -export-dynamic
 tilp_LDADD = @TICABLES_LIBS@ @TIFILES_LIBS@ @TICALCS_LIBS@ @TICONV_LIBS@ \
-	@GLIB_LIBS@ @GTK_LIBS@ \
-	@LIB_KDECORE@ @LIB_KDEUI@ @LIB_KIO@ @LIB_QT@ @KDE_LDFLAGS@ \
-	@QT_LDFLAGS@ @X_LDFLAGS@ @LIBZ@
+	@GLIB_LIBS@ @GTK_LIBS@ @LIBZ@
 tilp_SOURCES = *.h \
 	tilp_calcs.c tilp_cmdline.c tilp_config.c tilp_error.c \
 	tilp_files.c tilp_gif.c tilp_main.c \
_EOF'
    system "patch -Np1 -i tilp2.patch"
  end

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
           "CC=clc -fuse-ld=lld",
           "CXX=clc++ -fuse-ld=lld",
           "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--without-kde",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
