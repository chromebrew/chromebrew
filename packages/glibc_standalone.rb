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
       i686: '5b3a5e7256520a0435604b53f93a743d58ea07bea950fe3ee5f371c296f640f1',
     x86_64: '44220b48699ab3fb677d16c0b5172fac151c47edfa48015f170633a5a1dd18ed'
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

    # See https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/release-R136-16238.B/sys-libs/glibc/files/local/glibc-2.39/0002-libc-Speed-up-large-memcpy-on-Cortex-A7-A15.patch
    File.write '0002-libc-Speed-up-large-memcpy-on-Cortex-A7-A15.patch', <<~LIBC_SPEED_UP_PATCH_EOF
      From e5b7f5d719e8fd03de363bc5bb5c28f1429e56bd Mon Sep 17 00:00:00 2001
      From: Yunlian Jiang <yunlian@google.com>
      Date: Fri, 1 Aug 2014 15:19:34 -0700
      Subject: [PATCH 2/3] libc: Speed up large memcpy() on Cortex-A7/A15

      Details please see crbug://331427

      Experimentally it's been found that the "unaligned" memcpy() is
      actually faster for sufficiently large memory copies.  It appears that
      the changeover point is a little different for different processors,
      though.  For A15 there's a lot more run-to-run variance for
      medium-sized memcpy() but the changeover appears to be at ~16K.  For
      A7 (and maybe A9) the changeover seems to be a little further out.
      We think the variance in A15 memcpy() is is due to different physical
      addresses for the chunks of memory given to us by the kernel.  It is
      certain that the "aligned" code works faster at 4K and less and that
      the "unaligned" code works faster with very large chunks of memory.
      Since we care most about A15 performance and the A7 performance is not
      that much worse (and actually better for SDRAM transfers), we'll pick
      the number that's best for the A15.
      Tests on snow (A15 only):
      * Large (12M) aligned copies go from ~2350 MiB/s to ~2900 MiB/s.
      * Medium (96K) aligned copies go from ~5900 MiB/s to ~6300 MiB/s.
      * Medium (16K) aligned copies seem to be better but there's a lot of
        noise (old=8151.8, 8736.6, 8168.7; new=9364.9, 9829.5, 9639.0)
      * Small (4K, 8K) algined copies are unchanged.
      For A7-only on pit:
      * Large (12M) aligned copies go from 440 MiB/s to 930 MiB/s.
      * Medium (96K) aligned copies regress from ~2650 MiB/s to ~2400 MiB/s.
      * Medium (16K) aligned copies regress from ~3000 MiB/s to ~2800 MiB/s.
      * Small (4K, 8K) aligned copies are unchanged.
      See punybench changes at
       <https://chromium-review.googlesource.com/#/c/182168/3> for how this
      was tested.  For A15 changes I ran 3 times and averaged (there wasn't
      lots of variance except for 16K).  For A7 changes I ran 2 times.
      [Adrian: forward-ported to glibc 2.32]
      ---
       sysdeps/arm/armv7/multiarch/memcpy_impl.S | 4 ++++
       1 file changed, 4 insertions(+)

      diff --git a/sysdeps/arm/armv7/multiarch/memcpy_impl.S b/sysdeps/arm/armv7/multiarch/memcpy_impl.S
      index dc701827..ac171cde 100644
      --- a/sysdeps/arm/armv7/multiarch/memcpy_impl.S
      +++ b/sysdeps/arm/armv7/multiarch/memcpy_impl.S
      @@ -327,6 +327,10 @@ ENTRY(memcpy)
       \tcmp\ttmp1, tmp2
       \tbne\t.Lcpy_notaligned

      +\t/* Use the non-aligned code for >=16K; faster on A7/A15 (A9 too?) */
      +\tcmp\tcount, #0x4000
      +\tbge\t.Lcpy_notaligned
      +
       #ifdef USE_VFP
       \t/* Magic dust alert!  Force VFP on Cortex-A9.  Experiments show
       \t   that the FP pipeline is much better at streaming loads and
      --
      2.49.0
    LIBC_SPEED_UP_PATCH_EOF
    system 'patch', '-p1', '-i', '0002-libc-Speed-up-large-memcpy-on-Cortex-A7-A15.patch'
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
