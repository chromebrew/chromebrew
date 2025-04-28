require 'package'

class Glibc_standalone < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.41-1'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/glibc/glibc-#{version.partition('-')[0]}.tar.xz"
  source_sha256 'a5a26b22f545d6b7d7b3dd828e11e428f24f4fac43c934fb071b6a7d0828e901'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e19d852da8d4ead346d62003f9e5f15076ed5fae5bcd12dc9bd8f7f2602bc1b2',
     armv7l: 'e19d852da8d4ead346d62003f9e5f15076ed5fae5bcd12dc9bd8f7f2602bc1b2',
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
    # See https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/release-R136-16238.B/sys-libs/glibc/files/local/glibc-2.39/0009-Revert-Add-GLIBC_ABI_DT_RELR-for-DT_RELR-support.patch
    File.write '0001-Revert-Add-GLIBC_ABI_DT_RELR-for-DT_RELR-support.patch', <<~EOF
      From 13c1622b1f57a17d1254466df3261d1a25d589a1 Mon Sep 17 00:00:00 2001
      From: Adrian Ratiu <adrian.ratiu@collabora.com>
      Date: Tue, 27 Jun 2023 15:11:47 +0300
      Subject: [PATCH 1/3] Revert "Add GLIBC_ABI_DT_RELR for DT_RELR support"

      This partially reverts commit 57292f574156f817b7cbeb33ea62

      Adding the GLIBC_ABI_DT_RELR dependency breaks pre-built
      vendor binaries, so we decided to just revert this simple
      check, even though our binutils version supports adding it
      for the binaries we are able to rebuild.

      For more details see b:284450929 and CL 4632684
      ---
       elf/dl-version.c | 24 ------------------------
       1 file changed, 24 deletions(-)

      diff --git a/elf/dl-version.c b/elf/dl-version.c
      index d414bd1e..5208ec88 100644
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
      2.49.0
    EOF

    # See https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/release-R136-16238.B/sys-libs/glibc/files/local/glibc-2.39/0002-libc-Speed-up-large-memcpy-on-Cortex-A7-A15.patch
    File.write '0002-libc-Speed-up-large-memcpy-on-Cortex-A7-A15.patch', <<~EOF
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
    EOF

    File.write '0003-Hardcode-LD_LIBRARY_PATH-to-ensure-our-glibc-prefix-.patch', <<~EOF
      From b58cf17962030c4c2239324e76e05520d3cf0e97 Mon Sep 17 00:00:00 2001
      From: SupeChicken666 <me@supechicken666.dev>
      Date: Mon, 28 Apr 2025 03:24:41 +0800
      Subject: [PATCH 3/3] Hardcode LD_LIBRARY_PATH to ensure our glibc prefix is
       always appended

      Signed-off-by: SupeChicken666 <me@supechicken666.dev>
      ---
       elf/dl-support.c | 2 +-
       elf/rtld.c       | 2 +-
       2 files changed, 2 insertions(+), 2 deletions(-)

      diff --git a/elf/dl-support.c b/elf/dl-support.c
      index a7d5a5e8..667c2c2f 100644
      --- a/elf/dl-support.c
      +++ b/elf/dl-support.c
      @@ -296,7 +296,7 @@ _dl_non_dynamic_init (void)

         /* Initialize the data structures for the search paths for shared
            objects.  */
      -  _dl_init_paths (getenv ("LD_LIBRARY_PATH"), "LD_LIBRARY_PATH",
      +  _dl_init_paths ("#{CREW_PREFIX}/opt/glibc-libs:#{CREW_LIB_PREFIX}:/#{ARCH_LIB}", "LD_LIBRARY_PATH",
       \t\t  /* No glibc-hwcaps selection support in statically
       \t\t     linked binaries.  */
       \t\t  NULL, NULL);
      diff --git a/elf/rtld.c b/elf/rtld.c
      index 00bec153..435a8a46 100644
      --- a/elf/rtld.c
      +++ b/elf/rtld.c
      @@ -2647,7 +2647,7 @@ process_envvars_default (struct dl_main_state *state)
       \t  /* The library search path.  */
       \t  if (memcmp (envline, "LIBRARY_PATH", 12) == 0)
       \t    {
      -\t      state->library_path = &envline[13];
      +\t      state->library_path = "#{CREW_PREFIX}/opt/glibc-libs:#{CREW_LIB_PREFIX}:/#{ARCH_LIB}";
       \t      state->library_path_source = "LD_LIBRARY_PATH";
       \t      break;
       \t    }
      --
      2.49.0
    EOF

    system 'filefix'

    Dir.glob('*.patch') do |patch|
      puts "Applying #{patch}...".yellow
      system 'patch', '-p1', '-i', patch
    end
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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'localedata/install-locales', chdir: 'builddir'
  end
end
