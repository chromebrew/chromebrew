require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.12'
  compatibility 'all'
  license 'GPL-3'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.12.tar.xz'
  source_sha256 'ce5e03e519f637e1f814011ace35c4f87b33c0bbabeec35baf5fbd3479e91956'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.12_armv7l/gzip-1.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.12_armv7l/gzip-1.12-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.12_x86_64/gzip-1.12-chromeos-x86_64.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.12_i686/gzip-1.12-chromeos-i686.tar.zst'
  })
  binary_sha256({
    aarch64: '2a699b3eba6ff714a780e8c2c32131c842f2960d2eb04de280268c54d111aed1',
     armv7l: '2a699b3eba6ff714a780e8c2c32131c842f2960d2eb04de280268c54d111aed1',
     x86_64: 'bd27a2c304c111cd4983416745ff83c210f15773f2dc5fd864369d7617ef904a',
       i686: '9beef9bcb1bbd34f2c476e1412854a72181104b4d7db79ffec815818b93a8e81'
  })

  def self.patch
    return unless ARCH == 'i686'

    # Patch from https://git.savannah.gnu.org/cgit/gnulib.git/diff/?id=84863a1c4dc8cca8fb0f6f670f67779cdd2d543b
    @gnulibpatch = <<~'PATCH_EOF'
      diff --git a/lib/string.in.h b/lib/string.in.h
      index b6840fa..33160b2 100644
      --- a/lib/string.in.h
      +++ b/lib/string.in.h
      @@ -583,7 +583,7 @@ _GL_FUNCDECL_RPL (strndup, char *,
                         _GL_ATTRIBUTE_MALLOC _GL_ATTRIBUTE_DEALLOC_FREE);
       _GL_CXXALIAS_RPL (strndup, char *, (char const *__s, size_t __n));
       # else
      -#  if !@HAVE_DECL_STRNDUP@ || __GNUC__ >= 11
      +#  if !@HAVE_DECL_STRNDUP@ || (__GNUC__ >= 11 && !defined strndup)
       _GL_FUNCDECL_SYS (strndup, char *,
                         (char const *__s, size_t __n)
                         _GL_ARG_NONNULL ((1))
      @@ -593,7 +593,7 @@ _GL_CXXALIAS_SYS (strndup, char *, (char const *__s, size_t __n));
       # endif
       _GL_CXXALIASWARN (strndup);
       #else
      -# if __GNUC__ >= 11
      +# if __GNUC__ >= 11 && !defined strndup
       /* For -Wmismatched-dealloc: Associate strndup with free or rpl_free.  */
       _GL_FUNCDECL_SYS (strndup, char *,
                         (char const *__s, size_t __n)
    PATCH_EOF
    File.write('gnulib.patch', @gnulibpatch)
    system 'patch -p 1 -i gnulib.patch'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-threads=posix"
    system "mold -run make -j #{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
