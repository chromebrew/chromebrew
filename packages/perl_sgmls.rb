require 'package'

class Perl_sgmls < Package
  description 'SGMLS - class for postprocessing the output from the sgmls and nsgmls parsers.'
  homepage 'https://search.cpan.org/dist/SGMLSpm/'
  version '1.1-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-3_armv7l/perl_sgmls-1.1-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-3_armv7l/perl_sgmls-1.1-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-3_i686/perl_sgmls-1.1-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_sgmls/1.1-3_x86_64/perl_sgmls-1.1-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '623f608b766f6defa64f3aa67ccc94d7ac3ad56be8a62c6d0bfaf5aa2958a501',
     armv7l: '623f608b766f6defa64f3aa67ccc94d7ac3ad56be8a62c6d0bfaf5aa2958a501',
       i686: 'df471c87b091c534624f113108e315af9e3ae96aee3d4d5d60f8f85b14aafdec',
     x86_64: '415e030d98d8af9d7afbafc97027e107fb1f3489a44c8615697694379cc79adf'
  })

  depends_on 'perl_module_build' => :build

  def self.patch
    # For some reason this file doesn't have the proper permissions in the tarball
    system 'chmod 0644 MYMETA.yml'
  end

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
