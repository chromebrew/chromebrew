require 'package'

class Gnupg < Package
  description 'GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP).'
  homepage 'https://gnupg.org/'
  version '2.3.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://dev.gnupg.org/source/gnupg.git'
  git_hashtag "gnupg-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.3.4_armv7l/gnupg-2.3.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.3.4_armv7l/gnupg-2.3.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.3.4_i686/gnupg-2.3.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnupg/2.3.4_x86_64/gnupg-2.3.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f581a00c668be835091c809538f2ec6be54854daf9a5c413d9919e629881dd8e',
     armv7l: 'f581a00c668be835091c809538f2ec6be54854daf9a5c413d9919e629881dd8e',
       i686: '6178b043fd65b6ebfa7ca36a4379ef9fbae8903f2f088cdc7cf2618f8a685305',
     x86_64: '2d42176822fa0c0b0aa5d32b85296e235c5195747a31b47a4e5f68c62614d639'
  })

  depends_on 'bz2'
  depends_on 'fig2dev' => :build
  depends_on 'imagemagick7' => :build
  depends_on 'libassuan'
  depends_on 'libgcrypt'
  depends_on 'libksba'
  depends_on 'pinentry'

  def self.patch
    # See https://dev.gnupg.org/T5215
    # Just add -fcommon to compile options to work around this issue.
    #  system "git cherry-pick 9ad423d7218c"
    @gcc10patch = <<~'GCC10PATCHEOF'
      diff -NPaur a/configure.ac b/configure.ac
      --- a/configure.ac	2022-01-04 02:22:14.157482995 +0000
      +++ b/configure.ac	2022-01-04 02:25:52.050655151 +0000
      @@ -1690,7 +1690,7 @@
           # warning options and the user should have a chance of overriding
           # them.
           if test "$USE_MAINTAINER_MODE" = "yes"; then
      -        mycflags="$mycflags -O3 -Wall -Wcast-align -Wshadow -Wstrict-prototypes"
      +        mycflags="$mycflags -O3 -Wall -fcommon -Wcast-align -Wshadow -Wstrict-prototypes"
               mycflags="$mycflags -Wformat -Wno-format-y2k -Wformat-security"
               if test x"$_gcc_silent_wno" = xyes ; then
                 _gcc_wopt=yes
      @@ -1731,7 +1731,7 @@
               fi

           else
      -        mycflags="$mycflags -Wall"
      +        mycflags="$mycflags -Wall -fcommon"
               if test x"$_gcc_silent_wno" = xyes ; then
                 mycflags="$mycflags -Wno-format-zero-length"
               fi
    GCC10PATCHEOF
    File.write('gcc10.patch', @gcc10patch)
    system 'patch -Np1 -i gcc10.patch'
  end

  def self.build
    system './autogen.sh --force'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-maintainer-mode \
              --enable-all-tests \
              --with-capabilities \
              --with-zlib \
              --with-bzip2 \
              --with-readline"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
