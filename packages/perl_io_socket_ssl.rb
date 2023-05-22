require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.083-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.083.tar.gz'
  source_sha256 '904ef28765440a97d8a9a0df597f8c3d7f3cb0a053d1b082c10bed03bc802069'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.074_armv7l/perl_io_socket_ssl-2.074-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.074_armv7l/perl_io_socket_ssl-2.074-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.074_i686/perl_io_socket_ssl-2.074-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.074_x86_64/perl_io_socket_ssl-2.074-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '365cbbc9e9ca765e9d42666ac73b0405c7f1c4bfdd9d53c5b46cebc028489c47',
     armv7l: '365cbbc9e9ca765e9d42666ac73b0405c7f1c4bfdd9d53c5b46cebc028489c47',
       i686: '7ff44795e5843c9dad03ffb6a033e1ab92c8cb302622092ad77a94b31e11680a',
     x86_64: 'c5bb85cb8cf6a216f6ae8acdaf16f083c799eb2c528c3468d80644a99d3ef9af'
  })

  depends_on 'perl_net_ssleay'
  depends_on 'perl_mozilla_ca'

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
