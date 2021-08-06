require 'package'

class Perl_net_ssleay < Package
  description 'Perl extension for using OpenSSL'
  homepage 'https://search.cpan.org/dist/Net-SSLeay/'
  version '1.90'
  license 'BSD'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-#{version}.tar.gz"
  source_sha256 'f8696cfaca98234679efeedc288a9398fcf77176f1f515dbc589ada7c650dc93'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.90_armv7l/perl_net_ssleay-1.90-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.90_armv7l/perl_net_ssleay-1.90-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_net_ssleay/1.90_x86_64/perl_net_ssleay-1.90-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4ed9c05974afa9edf1006c363e3f7a58607b3bff2714013feacad40a6b071f1c',
     armv7l: '4ed9c05974afa9edf1006c363e3f7a58607b3bff2714013feacad40a6b071f1c',
     x86_64: '65271f786fbf6480fea9b9e95e05d15227add6cb418e1dae9ba97bfe7e35424e'
  })

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
