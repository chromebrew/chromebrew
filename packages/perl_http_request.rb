require 'package'

class Perl_http_request < Package
  description 'HTTP style request message'
  homepage 'https://metacpan.org/pod/HTTP::Request'
  version '6.44-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.44.tar.gz'
  source_sha256 '398b647bf45aa972f432ec0111f6617742ba32fc773c6612d21f64ab4eacbca1'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.38_armv7l/perl_http_request-6.44-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.38_armv7l/perl_http_request-6.44-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.38_i686/perl_http_request-6.44-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.38_x86_64/perl_http_request-6.44-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7dcb4d1b112c26610fcacc9a2a52933218bdc7dc2b8f290d5333c25d88b7d9cc',
     armv7l: '7dcb4d1b112c26610fcacc9a2a52933218bdc7dc2b8f290d5333c25d88b7d9cc',
       i686: '51c88a3fa2116f56c512f7b5acf9c559e6d752fe494e7d7de9a9a42f2d7439cf',
     x86_64: 'b3ed7c867eae791237ec3d4ab6d84591bd910a0753c9ba31821c7a6db6d45006'
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
