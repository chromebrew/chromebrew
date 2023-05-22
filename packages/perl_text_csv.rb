require 'package'

class Perl_text_csv < Package
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version '2.02-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-2.02.tar.gz'
  source_sha256 '84120de3e10489ea8fbbb96411a340c32cafbe5cdff7dd9576b207081baa9d24'

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
