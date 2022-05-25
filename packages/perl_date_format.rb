require 'package'

class Perl_date_format < Package
  description 'Date formatting subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version '2.33-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.38_armv7l/perl_date_format-2.33-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.38_armv7l/perl_date_format-2.33-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.38_i686/perl_date_format-2.33-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-perl5.38_x86_64/perl_date_format-2.33-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '769865386a5318a5ad947c33ed09df30b593b3cc2e60b51dd74bd6dc1ea7a7e1',
     armv7l: '769865386a5318a5ad947c33ed09df30b593b3cc2e60b51dd74bd6dc1ea7a7e1',
       i686: '1501061bfda5e759766d595d3b6dde8d2e7b89d056ad765b1eea7dfcf03e69b2',
     x86_64: '9bf1099b4b85450b70870c40195324107472938b0699ff7a8d500296820896ab'
  })

  conflicts_ok #  conflicts with perl_xml_parser

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Conflict with perl_xml_parser package.
    # FileUtils.rm "#{CREW_PREFIX}/lib/perl5/site_perl/5.32.1/Date/Language/Amharic.pm"
  end
end
