require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  # version "0.25.1-a0e74b9-#{CREW_ICU_VER}"
  version "0.25.1-#{CREW_ICU_VER}"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  source_url "https://ftp.gnu.org/pub/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  source_sha256 'c70678c88589ee48e55ae1f3843935afa4be1466fb1bc737658dc933f60379f5'
  # source_url 'https://https.git.savannah.gnu.org/git/gettext.git'
  # git_hashtag 'a0e74b95831bfa37e3f4293b307c25d584b536f7'
  # git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f86e40b77f046b86822f6d7bbcca8d5073657a20b10997ae874601dc5c0bb24',
     armv7l: '2f86e40b77f046b86822f6d7bbcca8d5073657a20b10997ae874601dc5c0bb24',
       i686: '606b3b9a62738e950dec90a644c8a5ba062c6cbf8f5d2869f79a12db165b83ea',
     x86_64: 'ef3bcbd7d97d02b964860b28bb008bf41900a5013c19a77c7f35caf8bc06189f'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'wget2' => :build
  depends_on 'zlib' # R

  autotools_configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'

  def self.patch
    system './autopull.sh' unless File.executable? './configure'
    # https://cgit.git.savannah.gnu.org/cgit/gnulib.git/commit/?id=c44fe03b72687c9e913727724c29bdb49c1f86e3
    File.write 'gnulib_stringh.patch', <<~GNULIB_PATCH_EOF
      diff --git a/lib/string.in.h b/lib/string.in.h
      index e3d94b76c1..9a039c7ba0 100644
      --- a/lib/string.in.h
      +++ b/lib/string.in.h
      @@ -214,65 +214,85 @@ _GL_EXTERN_C void free (void *);

       /* Declarations for ISO C N3322.  */
       #if defined __GNUC__ && __GNUC__ >= 15 && !defined __clang__
      +# ifndef memcpy
       _GL_EXTERN_C void *memcpy (void *__dest, const void *__src, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (2, 3);
      +# endif
      +# ifndef memccpy
       _GL_EXTERN_C void *memccpy (void *__dest, const void *__src, int __c, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 4)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (2, 4);
      +# endif
      +# ifndef memmove
       _GL_EXTERN_C void *memmove (void *__dest, const void *__src, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (2, 3);
      +# endif
      +# ifndef strncpy
       _GL_EXTERN_C char *strncpy (char *__dest, const char *__src, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (2, 3);
      +# endif
      +# ifndef strndup
       _GL_EXTERN_C char *strndup (const char *__s, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 2);
      +# endif
      +# ifndef strncat
       _GL_EXTERN_C char *strncat (char *__dest, const char *__src, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ARG_NONNULL ((1)) _GL_ATTRIBUTE_NONNULL_IF_NONZERO (2, 3);
      +# endif
      +# ifndef memcmp
       _GL_EXTERN_C int memcmp (const void *__s1, const void *__s2, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (2, 3);
      +# endif
      +# ifndef strncmp
       _GL_EXTERN_C int strncmp (const char *__s1, const char *__s2, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (2, 3);
      -# ifndef __cplusplus
      +# endif
      +# if !defined memchr && !defined __cplusplus
       _GL_EXTERN_C void *memchr (const void *__s, int __c, size_t __n)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3);
       _GL_EXTERN_C void *memrchr (const void *__s, int __c, size_t __n)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3);
       # endif
      +# ifndef memset
       _GL_EXTERN_C void *memset (void *__s, int __c, size_t __n)
      -# if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
      +#  if __GLIBC__ + (__GLIBC_MINOR__ >= 2) > 2
         _GL_ATTRIBUTE_NOTHROW
      -# endif
      +#  endif
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3);
      +# endif
      +# ifndef memset_explicit
       _GL_EXTERN_C void *memset_explicit (void *__s, int __c, size_t __n)
         _GL_ATTRIBUTE_NONNULL_IF_NONZERO (1, 3);
      +# endif
       #endif
    GNULIB_PATCH_EOF
    pwd = `pwd`.chomp
    gnulib_dirs = %w[
      gettext-runtime/intl/gnulib-lib
      gettext-runtime/libasprintf/gnulib-lib
      gettext-runtime/gnulib-lib
      gettext-tools/gnulib-lib
      gettext-tools/libgettextpo
      libtextstyle/lib
    ]
    gnulib_dirs.each do |dir|
      Dir.chdir(dir) do
        system "patch -Np2 -i #{pwd}/gnulib_stringh.patch"
      end
    end
  end

  # cldr-plurals-1 test fails with icu75.1
  # run_tests
end
