require 'package'

class Perl_uri < Package
  description 'Uniform Resource Identifiers (absolute and relative)'
  homepage 'https://metacpan.org/pod/URI'
  version '5.19-perl5.38'
  license 'GPL PerlArtistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SI/SIMBABQUE/URI-5.19.tar.gz'
  source_sha256 '8fed5f819905c8a8e18f4447034322d042c3536b43c13ac1f09ba92e1a50a394'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.38_armv7l/perl_uri-5.19-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.38_armv7l/perl_uri-5.19-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.38_i686/perl_uri-5.19-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_uri/5.19-perl5.38_x86_64/perl_uri-5.19-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '60efa146dff8f02e99dd1a8493660d0b5397caff9a6848208221126e223b6efd',
     armv7l: '60efa146dff8f02e99dd1a8493660d0b5397caff9a6848208221126e223b6efd',
       i686: 'b15b9f19038ee0efe1f3017d60e3bf62783e7eb4215608130fb4cb426f3ede2c',
     x86_64: '2c21df63cd42d3a0217526f6cfbd19649022bc915d06ff6f3d9f50f7b7742e0b'
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
