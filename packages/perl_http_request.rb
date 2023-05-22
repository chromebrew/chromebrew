require 'package'

class Perl_http_request < Package
  description 'HTTP style request message'
  homepage 'https://metacpan.org/pod/HTTP::Request'
  version '6.44-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/HTTP-Message-6.44.tar.gz'
  source_sha256 '398b647bf45aa972f432ec0111f6617742ba32fc773c6612d21f64ab4eacbca1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.36_armv7l/perl_http_request-6.44-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.36_armv7l/perl_http_request-6.44-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.36_i686/perl_http_request-6.44-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_http_request/6.44-perl5.36_x86_64/perl_http_request-6.44-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fc796bc27ffc42e88718fbd65bb71fa5e7abdeb5a56f7c900b98c4d02507fb5f',
     armv7l: 'fc796bc27ffc42e88718fbd65bb71fa5e7abdeb5a56f7c900b98c4d02507fb5f',
       i686: 'd1758c5cff63a4c71a1177dc73eb0895aad0082bf1dd57d8df7942a5f183ce9a',
     x86_64: 'cfdd8682a9295549b6974a346cb7ccc69421f683a9740dd498ad08d494b7a500'
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
