require 'package'

class Valgrind < Package
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'http://valgrind.org/'
  version '3.13.0-2'
  source_url 'ftp://sourceware.org/pub/valgrind/valgrind-3.13.0.tar.bz2'
  source_sha256 'd76680ef03f00cd5e970bbdcd4e57fb1f6df7d2e2c071635ef2be74790190c3b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/valgrind-3.13.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/valgrind-3.13.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/valgrind-3.13.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/valgrind-3.13.0-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '859913a6f0f4a629f464fb01912e0e99d59a2f4dd0ef19a0ebfd8874180de0b9',
     armv7l: '859913a6f0f4a629f464fb01912e0e99d59a2f4dd0ef19a0ebfd8874180de0b9',
       i686: 'b6b11f8f929583a90fb3ea4fe939c320b4b8c0570280b572228daad1a6638867',
     x86_64: 'ae45af143f6b45454da54d426246e11b2cb5add80d134d1e617d625b756c6e6c',
  })

  depends_on 'patch' => :build

  def self.build
    system 'patch -p0 << EOF
--- coregrind/m_redir.c
+++ coregrind/m_redir.c
@@ -1340,9 +1340,11 @@
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
@@ -1367,6 +1369,7 @@
       add_hardwired_spec(
          "ld-linux-x86-64.so.2", "index",
          (Addr)&VG_(amd64_linux_REDIR_FOR_index), NULL);
+#if CI_HACK_strlen
       add_hardwired_spec(
          "ld-linux-x86-64.so.2", "strlen",
          (Addr)&VG_(amd64_linux_REDIR_FOR_strlen),
@@ -1378,6 +1381,7 @@
          complain_about_stripped_glibc_ldso
 #        endif
       );   
+#endif
    }
 
 #  elif defined(VGP_ppc32_linux)
@@ -1452,6 +1456,7 @@
       distros, ld.so\'s soname is ld-linux.so.3, but Ubuntu 14.04 on
       Odroid uses ld-linux-armhf.so.3 for some reason. */
    if (0==VG_(strcmp)("Memcheck", VG_(details).name)) {
+#if CI_HACK_strlen
       /* strlen */
       add_hardwired_spec(
          "ld-linux.so.3", "strlen",
@@ -1485,6 +1490,7 @@
          (Addr)&VG_(arm_linux_REDIR_FOR_strcmp),
          complain_about_stripped_glibc_ldso
       );
+#endif
    }
 
 #  elif defined(VGP_arm64_linux)
EOF'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
