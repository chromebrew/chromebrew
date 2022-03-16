require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.074'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.074.tar.gz'
  source_sha256 '36486b6be49da4d029819cf7069a7b41ed48af0c87e23be0f8e6aba23d08a832'

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
