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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.36_armv7l/perl_uri-5.19-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.36_armv7l/perl_uri-5.19-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.36_i686/perl_uri-5.19-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.36_x86_64/perl_uri-5.19-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c21958ae5ae418668120fcfebcf65ff37f4fb5550c688f8de6b3f01db6ede43c',
     armv7l: 'c21958ae5ae418668120fcfebcf65ff37f4fb5550c688f8de6b3f01db6ede43c',
       i686: '195d6f90fb767ac5ff4a900017caed04bb625dea9ce19c6702050e3b2dd80fef',
     x86_64: '9c394cf1a2f32f7ffc16b6cc00f71e1c655ec11c83791410ec0c416fa591b229'
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
