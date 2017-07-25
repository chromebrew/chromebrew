require 'package'

class Valgrind < Package
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'http://valgrind.org/'
  version '3.13.0'
  source_url 'ftp://sourceware.org/pub/valgrind/valgrind-3.13.0.tar.bz2'
  source_sha256 'd76680ef03f00cd5e970bbdcd4e57fb1f6df7d2e2c071635ef2be74790190c3b'

  def self.build
    system 'patch -p0 << EOF
--- coregrind/m_redir.c
+++ coregrind/m_redir.c
@@ -1214,9 +1214,11 @@
       add_hardwired_spec(
          "ld-linux.so.2", "index",
          (Addr)&VG_(x86_linux_REDIR_FOR_index), mandatory);
+#if CI_HACK_strlen
       add_hardwired_spec(
          "ld-linux.so.2", "strlen",
          (Addr)&VG_(x86_linux_REDIR_FOR_strlen), mandatory);
+#endif
    }

 #  elif defined(VGP_amd64_linux)
@@ -1238,6 +1240,7 @@
       the start, otherwise ld.so makes a lot of noise. */
    if (0==VG_(strcmp)("Memcheck", VG_(details).name)) {

+#if CI_HACK_strlen
       add_hardwired_spec(
          "ld-linux-x86-64.so.2", "strlen",
          (Addr)&VG_(amd64_linux_REDIR_FOR_strlen),
@@ -1251,6 +1254,8 @@
          complain_about_stripped_glibc_ldso
 #        endif
       );
+#endif
+
    }

 #  elif defined(VGP_ppc32_linux)
 EOF'
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
