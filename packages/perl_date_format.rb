require 'package'

class Perl_date_format < Package
  description 'Date formatting subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version "2.33-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '655989c018245fe36de39d17c0a7c32e185b6e9bae85616cb71068ba5dd2ffac',
     armv7l: '655989c018245fe36de39d17c0a7c32e185b6e9bae85616cb71068ba5dd2ffac',
       i686: '120b39d16ee00a279dd5d892b8f6e41a9e240f79fdca25740ab80c8660a2978a',
     x86_64: 'aeba039cfbb7ad8c8b1ed182694ae4a12cbfea2f22073b89d60634eff1947c6a'
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
    # FileUtils.rm "#{CREW_PREFIX}/lib/perl5/site_perl/5.40.0/Date/Language/Amharic.pm"
  end
end
