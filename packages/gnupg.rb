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
    aarch64: '4348fdfe6e565163a12fe76ad9c467bc58dcc8811f826343a6bf1bfe203fcca2',
     armv7l: '4348fdfe6e565163a12fe76ad9c467bc58dcc8811f826343a6bf1bfe203fcca2',
       i686: 'd3547c621c30cad0ea9eecd9906e86ae041f76ebb8564514bcb98da52da3dc0c',
     x86_64: '2096de764cf3fd0a77bc390cdfa7bb551a1ec7cb07239221fee6e1f09404f4d9'
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
    system 'patch -Np1 -F 2 -i gcc10.patch'
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
