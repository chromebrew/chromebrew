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
    aarch64: 'd47d72539205e3772dc110cfc33eb14dd46817c0d48cd4578995969a0535a64f',
     armv7l: 'd47d72539205e3772dc110cfc33eb14dd46817c0d48cd4578995969a0535a64f',
       i686: '9d61eae41e4f953e3804346e4b4212f212ed0ff627f63df804a5360fcf735ec2',
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
