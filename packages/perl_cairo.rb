require 'package'

class Perl_cairo < Package
  description 'Perl interface to the cairo 2d vector graphics library'
  homepage 'https://metacpan.org/pod/Cairo'
  version '1.109-perl5.38'
  license 'GPL 2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-1.109.tar.gz'
  source_sha256 '8219736e401c2311da5f515775de43fd87e6384b504da36a192f2b217643077f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo/1.109-perl5.38_armv7l/perl_cairo-1.109-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo/1.109-perl5.38_armv7l/perl_cairo-1.109-perl5.38-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo/1.109-perl5.38_x86_64/perl_cairo-1.109-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '36eaf3cf07d8710be8bfb1afabd2883da91f12e2a00c9ed440b756bb71b32358',
     armv7l: '36eaf3cf07d8710be8bfb1afabd2883da91f12e2a00c9ed440b756bb71b32358',
     x86_64: '32042074b1da6fc3ad942cd9dd43f111481a38c72ab19c25b768b8fa44e9fa36'
  })

  depends_on 'cairo' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build

  no_compile_needed

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
