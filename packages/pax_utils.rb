require 'package'

class Pax_utils < Package
  description 'ELF utils that can check files for security relevant properties'
  homepage 'https://wiki.gentoo.org/wiki/Hardened/PaX_Utilities'
  version '1.3.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://dev.gentoo.org/~xen0n/distfiles/pax-utils-1.3.4.tar.xz'
  source_sha256 '8baed2f9c5ae8e0cda1b9c75990864101afc64fad0a4616e10f3ff8ef891040b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pax_utils/1.3.4_armv7l/pax_utils-1.3.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pax_utils/1.3.4_armv7l/pax_utils-1.3.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pax_utils/1.3.4_i686/pax_utils-1.3.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pax_utils/1.3.4_x86_64/pax_utils-1.3.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54b27eaf90d7d9f0ec2852986c5549939ddba12b5232313996330ee0d9f4bdda',
     armv7l: '54b27eaf90d7d9f0ec2852986c5549939ddba12b5232313996330ee0d9f4bdda',
       i686: '05b1cd3d421d12e40ae555cb0b4422e332386d3ff5a6e0ee874ec9dfc94392eb',
     x86_64: '427a8ce76e866049a418d8f727de81a9a76e3cb30f5021ef5b079ed9a3c4cacb'
  })
  # The following two are only needed for build with autogen.sh
  # depends_on 'gnulib_git' => :build
  # depends_on 'xmlto' => :build
  depends_on 'glibc' # R
  depends_on 'py3_pyelftools'
  depends_on 'libcap' => :build
  depends_on 'libseccomp' => :build

  def self.patch
    # https://lists.gnu.org/archive/html/bug-gnulib/2022-04/msg00075.html
    @gnulib_patch = <<~'PATCHEOF'
      diff --git a/gnulib/import/string.in.h b/gnulib/import/string.in.h
      index b6840fa9121..cb344ed0498 100644
      --- a/autotools/gnulib/string.in.h
      +++ b/autotools/gnulib/string.in.h
      @@ -594,6 +594,7 @@ _GL_CXXALIAS_SYS (strndup, char *, (char const *__s, size_t __n));
       _GL_CXXALIASWARN (strndup);
       #else
       # if __GNUC__ >= 11
      +#undef strndup
       /* For -Wmismatched-dealloc: Associate strndup with free or rpl_free.  */
       _GL_FUNCDECL_SYS (strndup, char *,
                         (char const *__s, size_t __n)
    PATCHEOF
    File.write('gnulib.patch', @gnulib_patch)
    system 'patch -Np1 -i gnulib.patch'
    system "sed -i 's|/usr/bin/env python|/usr/bin/env python3|g' lddtree.py"
  end

  def self.build
    # system './autogen.sh'
    system "./configure \
      #{CREW_OPTIONS} \
      --with-caps \
      --with-seccomp \
      --with-python"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
