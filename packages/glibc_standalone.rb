require 'package'

class Glibc_standalone < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.41'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/glibc/glibc-#{version}.tar.xz"
  source_sha256 'a5a26b22f545d6b7d7b3dd828e11e428f24f4fac43c934fb071b6a7d0828e901'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d34f1aea3003156670485deecf5da4ff3f377de5260082edd1e27e3e8aa907e',
     armv7l: '4d34f1aea3003156670485deecf5da4ff3f377de5260082edd1e27e3e8aa907e',
       i686: '1234567',
     x86_64: '595548c1f923322526925698a4b2fec064112f78878375388fb5889583619f2f'
  })

  depends_on 'gawk' => :build
  depends_on 'filecmd' # L Fixes creating symlinks on a fresh install.
  depends_on 'libidn2' => :build
  depends_on 'llvm' => :build
  depends_on 'texinfo' => :build
  depends_on 'libxcrypt' # Latest glibc removed libcrypt.so, add this for backward compatibility
  depends_on 'patchelf' # L
  depends_on 'glibc' # R

  conflicts_ok
  no_env_options
  no_shrink

  def self.patch
    File.write 'hardcode-library-path.patch', <<~EOF
      diff -Nur a/elf/dl-support.c b/elf/dl-support.c
      --- a/elf/dl-support.c    2025-04-23 01:58:17.265974714 +0800
      +++ b/elf/dl-support.c    2025-04-23 14:38:27.373033131 +0800
      @@ -296,7 +296,7 @@

         /* Initialize the data structures for the search paths for shared
            objects.  */
      -  _dl_init_paths (getenv ("LD_LIBRARY_PATH"), "LD_LIBRARY_PATH",
      +  _dl_init_paths ("#{CREW_PREFIX}/opt/glibc-libs:#{CREW_LIB_PREFIX}:/#{ARCH_LIB}", "LD_LIBRARY_PATH",
       \t\t  /* No glibc-hwcaps selection support in statically
       \t\t     linked binaries.  */
       \t\t  NULL, NULL);
      diff -Nur a/elf/rtld.c b/elf/rtld.c
      --- a/elf/rtld.c    2025-04-23 04:04:02.230377659 +0800
      +++ b/elf/rtld.c    2025-04-23 14:37:52.298031258 +0800
      @@ -2647,7 +2647,7 @@
       \t  /* The library search path.  */
       \t  if (memcmp (envline, "LIBRARY_PATH", 12) == 0)
       \t    {
      -\t      state->library_path = &envline[13];
      +\t      state->library_path = "#{CREW_PREFIX}/opt/glibc-libs:#{CREW_LIB_PREFIX}:/#{ARCH_LIB}";
       \t      state->library_path_source = "LD_LIBRARY_PATH";
       \t      break;
       \t    }
    EOF

    system 'filefix'
    system 'patch', '-p1', '-i', 'hardcode-library-path.patch'
  end

  def self.build
    glibc_libdir = File.join(CREW_PREFIX, 'opt/glibc-libs')

    build_env = {
      CFLAGS:   '-O3 -pipe -fPIC -fno-lto -fuse-ld=lld',
      CXXFLAGS: '-O3 -pipe -fPIC -fno-lto -fuse-ld=lld',
      LD:       'ld.lld' # use lld here as mold will segfault
    }

    config_opts = %W[
      --prefix=#{CREW_PREFIX}
      --libdir=#{glibc_libdir}
      --libexecdir=#{CREW_PREFIX}/libexec
      --mandir=#{CREW_PREFIX}/man
      --with-headers=#{CREW_PREFIX}/include
      --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new
      --enable-bind-now
      --enable-fortify-source
      --enable-kernel=#{(ARCH == 'i686') ? '3.2' : '4.4'}
      --disable-nscd
      --disable-profile
      --disable-sanity-checks
      --disable-werror
      --without-cvs
      --without-selinux
    ]

    config_opts << '--enable-cet' unless ARCH == 'i686'

    FileUtils.mkdir_p 'builddir'
    Dir.chdir('builddir') do
      File.write 'configparms', <<~EOF
        slibdir=#{glibc_libdir}
        rtlddir=#{glibc_libdir}
        sbindir=#{CREW_PREFIX}/bin
        rootsbindir=#{CREW_PREFIX}/bin
      EOF

      system build_env.transform_keys(&:to_s), '../configure', *config_opts
      system 'make', "PARALLELMFLAGS='-j #{CREW_NPROC}'"
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install', chdir: 'builddir'
  end
end
