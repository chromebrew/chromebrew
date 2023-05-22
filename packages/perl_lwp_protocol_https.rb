require 'package'

class Perl_lwp_protocol_https < Package
  description 'Provide https support for LWP::UserAgent'
  homepage 'https://metacpan.org/pod/LWP::Protocol::https'
  version '6.10-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.10.tar.gz'
  source_sha256 'cecfc31fe2d4fc854cac47fce13d3a502e8fdfe60c5bc1c09535743185f2a86c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.36_armv7l/perl_lwp_protocol_https-6.10-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.36_armv7l/perl_lwp_protocol_https-6.10-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.36_i686/perl_lwp_protocol_https-6.10-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.36_x86_64/perl_lwp_protocol_https-6.10-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '878736610a26427ecf236e35f63f7fc8fa4aa4758e95032f71d30facc9be99cd',
     armv7l: '878736610a26427ecf236e35f63f7fc8fa4aa4758e95032f71d30facc9be99cd',
       i686: '81e4fcf35d1fd1be81f6e92552c20a4ba37d753dab279e230f5750ec560fddeb',
     x86_64: 'f70a50ae4d5c045446b9ea81fdb6c95e9c77694fb2c12dee93e47edfcda7a835'
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
