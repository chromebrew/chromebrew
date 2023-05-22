require 'package'

class Perl_cairo < Package
  description 'Perl interface to the cairo 2d vector graphics library'
  homepage 'https://metacpan.org/pod/Cairo'
  version '1.109-perl5.36'
  license 'GPL 2.1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/Cairo-1.109.tar.gz'
  source_sha256 '8219736e401c2311da5f515775de43fd87e6384b504da36a192f2b217643077f'

  depends_on 'cairo'
  depends_on 'perl_extutils_depends'
  depends_on 'perl_extutils_pkgconfig'

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
