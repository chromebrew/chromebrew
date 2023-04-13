require 'package'

class Pcre < Package
  description 'The PCRE library is a set of functions that implement regular expression pattern matching using the same syntax and semantics as Perl 5.'
  homepage 'http://pcre.org/'
  @_ver = '8.45'
  version @_ver
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.bz2'
  source_sha256 '4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre/8.45_armv7l/pcre-8.45-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre/8.45_armv7l/pcre-8.45-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre/8.45_i686/pcre-8.45-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pcre/8.45_x86_64/pcre-8.45-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '925da859f7c9b10946cdbd731549de593a7990a1d73f24dc683512d60aea4b2e',
     armv7l: '925da859f7c9b10946cdbd731549de593a7990a1d73f24dc683512d60aea4b2e',
       i686: 'dcc02d2beb02b9b6e901da65913be151e3d6c564ffa2e77ec3ccfe7bcf9539f0',
     x86_64: 'ee4f6f40c9acfd64e9c93281d8a5a6b8ac1aab3da5f11c7bbf5bfddc2bedc2d3'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'readline' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --enable-shared \
      --with-pic \
      --enable-unicode-properties \
      --enable-pcre16 \
      --enable-pcre32 \
      --enable-jit \
      --enable-pcretest-libreadline"
    system 'make'
  end

  def self.check
    # `make check` fails because of an issue with locale.
    # All but one test passes.
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
