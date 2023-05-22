require 'package'

class Perl_extutils_pkgconfig < Package
  description 'Simplistic interface to pkg-config'
  homepage 'https://metacpan.org/pod/ExtUtils::PkgConfig'
  version '1.16-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/X/XA/XAOC/ExtUtils-PkgConfig-1.16.tar.gz'
  source_sha256 'bbeaced995d7d8d10cfc51a3a5a66da41ceb2bc04fedcab50e10e6300e801c6e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_pkgconfig/1.16-perl5.36_armv7l/perl_extutils_pkgconfig-1.16-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_pkgconfig/1.16-perl5.36_armv7l/perl_extutils_pkgconfig-1.16-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_pkgconfig/1.16-perl5.36_i686/perl_extutils_pkgconfig-1.16-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_extutils_pkgconfig/1.16-perl5.36_x86_64/perl_extutils_pkgconfig-1.16-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3a54d3f761d5aa46ccce9df8bafcf9bab703b8306af1c507f28a2af4c50275a6',
     armv7l: '3a54d3f761d5aa46ccce9df8bafcf9bab703b8306af1c507f28a2af4c50275a6',
       i686: '71a55b4086161a9013ccc2cd18b6baf06d34f9cfe9d47ec81b86e6f3163f38f2',
     x86_64: '1bc81a36b6051c8a7f2d017c6824ea61673a4a3b27d05fb12ce9e1cdd2cee0d3'
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
