require 'package'

class Coreutils < Package
  description 'The GNU Core Utilities are the basic file, shell and text manipulation utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/coreutils/coreutils.html'
  @_ver = '9.1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/coreutils/coreutils-#{@_ver}.tar.xz"
  source_sha256 '61a1f410d78ba7e7f37a5a4f50e6d1320aca33375484a3255eddf17a38580423'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.1_armv7l/coreutils-9.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.1_armv7l/coreutils-9.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.1_i686/coreutils-9.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/coreutils/9.1_x86_64/coreutils-9.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '384491c5353bab5d14d731699c5d262947d20dfaa6485eeccb610e566b831b0c',
     armv7l: '384491c5353bab5d14d731699c5d262947d20dfaa6485eeccb610e566b831b0c',
       i686: 'd65d86505f3cb596e9ff3190caace4d6f1d8e01a8aa8424e15a398d47b1e275b',
     x86_64: '0857a1e3af002c5cf70e5ed1d3f6af033c7fcd4e37fbebb6ce01c6730151686d'
  })

  depends_on 'libcap' # R
  no_patchelf

  def self.preflight
    %w[uutils_coreutils].each do |cutils|
      next unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{cutils}.filelist"

      puts "#{cutils} installed and conflicts with this version.".orange
      puts 'To install this version, execute the following:'.lightblue
      abort "crew remove #{cutils} && crew install coreutils".lightblue
    end
  end

  def self.patch
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
    system 'patch -p 1 -i gnulib.patch' if ARCH == 'i686'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "cat <<'EOF'> #{CREW_DEST_PREFIX}/bin/arch
#!/bin/bash
echo \"#{ARCH}\"
EOF"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/arch"
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
