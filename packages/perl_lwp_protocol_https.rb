require 'package'

class Perl_lwp_protocol_https < Package
  description 'Provide https support for LWP::UserAgent'
  homepage 'https://metacpan.org/pod/LWP::Protocol::https'
  version '6.10-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/O/OA/OALDERS/LWP-Protocol-https-6.10.tar.gz'
  source_sha256 'cecfc31fe2d4fc854cac47fce13d3a502e8fdfe60c5bc1c09535743185f2a86c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.38_armv7l/perl_lwp_protocol_https-6.10-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.38_armv7l/perl_lwp_protocol_https-6.10-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.38_i686/perl_lwp_protocol_https-6.10-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_lwp_protocol_https/6.10-perl5.38_x86_64/perl_lwp_protocol_https-6.10-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9b9232091cc3337f593b3d568a601c4c122074669c78b85b540c48984d81cbe7',
     armv7l: '9b9232091cc3337f593b3d568a601c4c122074669c78b85b540c48984d81cbe7',
       i686: 'cdb8b8b7f67f1d64fff17a93df98747ca3472de3c774f7dc58d8c9cb4e9c8e7b',
     x86_64: 'e6d9c1d85428390d57dd25a2c6698750e9d5c990dfdbaa9cffb5a541871c5efe'
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
