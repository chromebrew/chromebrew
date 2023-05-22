require 'package'

class Perl_cairo < Package
  description 'Perl interface to the cairo 2d vector graphics library'
  homepage 'https://metacpan.org/pod/Cairo'
  version '1.109-perl5.36'
  license 'GPL 2.1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-1.109.tar.gz'
  source_sha256 '8219736e401c2311da5f515775de43fd87e6384b504da36a192f2b217643077f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo/1.109-perl5.36_armv7l/perl_cairo-1.109-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo/1.109-perl5.36_armv7l/perl_cairo-1.109-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo/1.109-perl5.36_i686/perl_cairo-1.109-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_cairo/1.109-perl5.36_x86_64/perl_cairo-1.109-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1ed3fce3577e3005aeafa7857056e06842300ecc948f4974069194d42120797e',
     armv7l: '1ed3fce3577e3005aeafa7857056e06842300ecc948f4974069194d42120797e',
       i686: '65b872a1b024593a972a333d23e384b4fb4a96be125e8dea6943601b9d6aaeb2',
     x86_64: '97026ffe93a0b0a27bab9332c6b8a5664d0b5071298ad4b67d863a4b08792262'
  })

  depends_on 'cairo'
  depends_on 'perl_extutils_depends' => :build
  depends_on 'perl_extutils_pkgconfig' => :build
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R

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
