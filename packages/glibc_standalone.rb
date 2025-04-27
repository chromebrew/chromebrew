require 'package'

class Glibc_standalone < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.41-1'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/glibc/glibc-#{version.split('-').first}.tar.xz"
  source_sha256 'a5a26b22f545d6b7d7b3dd828e11e428f24f4fac43c934fb071b6a7d0828e901'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9517b475debdb5c205f34e03f1d358c178c6e0448de39ca7ce80061dd83ee8c',
     armv7l: 'f9517b475debdb5c205f34e03f1d358c178c6e0448de39ca7ce80061dd83ee8c',
       i686: '77a95bfa9bdf58c02e9534645eb45886a8bc0a0043d4ba0bbf39bd862bd63aeb',
     x86_64: '184bc7a001362701d96c0fa3458aeef3355a8b1654f50623b372b07e833a2b05'
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
    # See https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/release-R136-16238.B/sys-libs/glibc/files/local/glibc-2.39/0009-Revert-Add-GLIBC_ABI_DT_RELR-for-DT_RELR-support.patch?pli=1%2F
    File.write '0009-Revert-Add-GLIBC_ABI_DT_RELR-for-DT_RELR-support.patch', <<~GLIBC_ABI_DT_RELR_PATCH_EOF
      diff --git a/elf/dl-version.c b/elf/dl-version.c
      index 8966d612cc79..7fb5cb16d47b 100644
      --- a/elf/dl-version.c
      +++ b/elf/dl-version.c
      @@ -359,30 +359,6 @@ _dl_check_map_versions (struct link_map *map, int verbose, int trace_mode)
       \t}
           }

      -  /* When there is a DT_VERNEED entry with libc.so on DT_NEEDED, issue
      -     an error if there is a DT_RELR entry without GLIBC_ABI_DT_RELR
      -     dependency.  */
      -  if (dyn != NULL
      -      && map->l_info[DT_NEEDED] != NULL
      -      && map->l_info[DT_RELR] != NULL
      -      && __glibc_unlikely (!map->l_dt_relr_ref))
      -    {
      -      const char *strtab = (const void *) D_PTR (map, l_info[DT_STRTAB]);
      -      const ElfW(Dyn) *d;
      -      for (d = map->l_ld; d->d_tag != DT_NULL; ++d)
      -\tif (d->d_tag == DT_NEEDED)
      -\t  {
      -\t    const char *name = strtab + d->d_un.d_val;
      -\t    if (strncmp (name, "libc.so.", 8) == 0)
      -\t      {
      -\t\t_dl_exception_create
      -\t\t  (&exception, DSO_FILENAME (map->l_name),
      -\t\t   N_("DT_RELR without GLIBC_ABI_DT_RELR dependency"));
      -\t\tgoto call_error;
      -\t      }
      -\t  }
      -    }
      -
         return result;
       }

      --
      2.41.0
    GLIBC_ABI_DT_RELR_PATCH_EOF
    system 'patch', '-p1', '-i', '0009-Revert-Add-GLIBC_ABI_DT_RELR-for-DT_RELR-support.patch'
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
      --enable-kernel=#{ARCH.eql?('i686') ? '3.2' : '4.4'}
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
      system "make PARALLELMFLAGS='-j #{CREW_NPROC}'"
    end
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install', chdir: 'builddir'
    system "make -j1 DESTDIR=#{CREW_DEST_DIR} localedata/install-locales || make -j1 DESTDIR=#{CREW_DEST_DIR} localedata/install-locales", chdir: 'builddir'
  end
end
