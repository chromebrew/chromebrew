require 'package'

class Perl_date_format < Package
  description 'Date formatting subroutines'
  homepage 'https://metacpan.org/pod/Date::Format'
  version '2.33-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/TimeDate-2.33.tar.gz'
  source_sha256 'c0b69c4b039de6f501b0d9f13ec58c86b040c1f7e9b27ef249651c143d605eb2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-1_armv7l/perl_date_format-2.33-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-1_armv7l/perl_date_format-2.33-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-1_i686/perl_date_format-2.33-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_date_format/2.33-1_x86_64/perl_date_format-2.33-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '58c1886e79ef37627314f0ffa838d11190e45de6ff17e02de21af1d129bff4b3',
     armv7l: '58c1886e79ef37627314f0ffa838d11190e45de6ff17e02de21af1d129bff4b3',
       i686: 'f81f2743e65366196693cf781d30ec7b0a0c9387cee583b6789245f81eb2ffeb',
     x86_64: '2998c9fed1b23f2b438c4320dae495129b3f7067e770cce38983a868088f1db5'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Conflict with perl_xml_parser package.
    FileUtils.rm "#{CREW_PREFIX}/lib/perl5/site_perl/5.32.1/Date/Language/Amharic.pm"
  end
end
