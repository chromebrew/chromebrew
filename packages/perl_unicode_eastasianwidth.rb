require 'package'

class Perl_unicode_eastasianwidth < Package
  description 'Perl Unicode::EastAsianWidth - East Asian Width properties.'
  homepage 'https://metacpan.org/pod/Unicode::EastAsianWidth'
  version '12.0-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/A/AU/AUDREYT/Unicode-EastAsianWidth-12.0.tar.gz'
  source_sha256 '2a5bfd926c4fe5f77e6137da2c31ac2545282ae5fec6e9af0fdd403555a90ff4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-2_armv7l/perl_unicode_eastasianwidth-12.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-2_armv7l/perl_unicode_eastasianwidth-12.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-2_i686/perl_unicode_eastasianwidth-12.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_unicode_eastasianwidth/12.0-2_x86_64/perl_unicode_eastasianwidth-12.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8a72eba49c075cbb13b7e8a7575df34f463c7d4e73f4e9fadcd7b4c3ea3d0c7c',
     armv7l: '8a72eba49c075cbb13b7e8a7575df34f463c7d4e73f4e9fadcd7b4c3ea3d0c7c',
       i686: '98e1a3e9f2591f5342d512b67c916f87480d43276ee492d2238972ae8235d3f5',
     x86_64: '7f8e2ade0b2d5481d8efe3f5a830baa814aacfb9897844aae067b7cb340b9183'
  })

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
