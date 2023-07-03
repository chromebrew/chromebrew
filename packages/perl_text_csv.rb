require 'package'

class Perl_text_csv < Package
  description 'Comma-separated values manipulator (using XS or PurePerl)'
  homepage 'https://metacpan.org/pod/Text::CSV'
  version '2.02-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/Text-CSV-2.02.tar.gz'
  source_sha256 '84120de3e10489ea8fbbb96411a340c32cafbe5cdff7dd9576b207081baa9d24'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.38_armv7l/perl_text_csv-2.02-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.38_armv7l/perl_text_csv-2.02-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.38_i686/perl_text_csv-2.02-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_csv/2.02-perl5.38_x86_64/perl_text_csv-2.02-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd412d2354cc124a7da35eb06fe625261c3820c2fa887d35b941c8baa71db088d',
     armv7l: 'd412d2354cc124a7da35eb06fe625261c3820c2fa887d35b941c8baa71db088d',
       i686: '7db0afe944345373429589059bd965f17dba640c7e11aabca138d1570e80e96b',
     x86_64: '7c79482dbb145c7d123df207ac3d3a204bbbcf092db14db0a0e27cfd60673d6b'
  })

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
