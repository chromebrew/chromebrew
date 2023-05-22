require 'package'

class Perl_uri < Package
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version '5.19-perl5.36'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/URI-5.19.tar.gz'
  source_sha256 '8fed5f819905c8a8e18f4447034322d042c3536b43c13ac1f09ba92e1a50a394'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.36_i686/perl_uri-5.19-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.36_x86_64/perl_uri-5.19-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'd33b8eb741654e813f9eeb5e759c77b8142ac5264d2416bd7747fadb5f03590c',
  x86_64: '1a720b38165b50a7283820d66be02ae803df60f9717f5257bb3e38a8879ed471'
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
