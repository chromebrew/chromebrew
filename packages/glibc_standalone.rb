require 'package'

class Glibc_standalone < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.41'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftp.gnu.org/gnu/glibc/glibc-#{version}.tar.xz"
  source_sha256 'SKIP'
  binary_compression 'tar.zst'

  conflicts_ok
  no_env_options

  def self.patch
    File.write 'ld-library-path-hack.patch', <<~EOF
      --- a/dl-support.c      2025-04-23 01:58:17.265974714 +0800
      +++ b/dl-support.c      2025-04-23 02:17:11.885035310 +0800
      @@ -296,7 +296,12 @@

         /* Initialize the data structures for the search paths for shared
            objects.  */
      -  _dl_init_paths (getenv ("LD_LIBRARY_PATH"), "LD_LIBRARY_PATH",
      +
      +  /* Always append ${CREW_PREFIX}/opt/glibc-libs before LD_LIBRARY_PATH */
      +  const char ld_library_path[8192], *crew_prefix = getenv("CREW_PREFIX") ?: "/usr/local";
      +  snprintf(ld_library_path, sizeof(ld_library_path), "%s/opt/glibc-libs:%s", crew_prefix, getenv("LD_LIBRARY_PATH") ?: "");
      +
      +  _dl_init_paths (ld_library_path, "LD_LIBRARY_PATH",
                        /* No glibc-hwcaps selection support in statically
                           linked binaries.  */
                        NULL, NULL);
    EOF

    system 'filefix'
    system 'patch', '-p1', '-i', 'ld-library-path-hack.patch'
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
      --enable-cet
      --enable-fortify-source
      --enable-kernel=4.4
      --disable-profile
      --disable-sanity-checks
      --disable-werror
      --without-cvs
      --without-selinux
    ]

    FileUtils.mkdir_p 'builddir'
    Dir.chdir('builddir') do
      File.write 'configparms', <<~EOF
        slibdir=#{glibc_libdir}
        rtlddir=#{CREW_PREFIX}/bin
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
