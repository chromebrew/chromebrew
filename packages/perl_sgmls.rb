require 'package'

class Perl_sgmls < Package
  description 'SGMLS - class for postprocessing the output from the sgmls and nsgmls parsers.'
  homepage 'https://search.cpan.org/dist/SGMLSpm/'
  version '1.1-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/R/RA/RAAB/SGMLSpm-1.1.tar.gz'
  source_sha256 '550c9245291c8df2242f7e88f7921a0f636c7eec92c644418e7d89cfea70b2bd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59f819d4146063577a31cba64ce9f7586664e9eeb1ea2ff3d952b87a89f7f598',
     armv7l: '59f819d4146063577a31cba64ce9f7586664e9eeb1ea2ff3d952b87a89f7f598',
       i686: '62a69aeeffaafefcfbbbebe3ec65d6c64f5480cf1a4113eae31e2e3d2270acbb',
     x86_64: '6fff085bedfd64a418e582b6de1fdea3b78eb035ca55277f6f0a67096f9bcc2c'
  })

  depends_on 'perl_module_build' => :build

  def self.patch
    # For some reason this file doesn't have the proper permissions in the tarball
    FileUtils.chmod 0o644, 'MYMETA.yml'
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
