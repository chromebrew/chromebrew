require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.071'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.071.tar.gz'
  source_sha256 '40da40948ecc9c787ed39c95715872679eebfd54243721174993a2003e32ab0a'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.068-1_i686/perl_io_socket_ssl-2.068-1-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.071_armv7l/perl_io_socket_ssl-2.071-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.071_armv7l/perl_io_socket_ssl-2.071-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.071_x86_64/perl_io_socket_ssl-2.071-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: '24df6cac573463073b723da4b9b1a65380e2cdd67a053aabb9e61491410960c7',
    aarch64: '9fc1e546ec21478fb4ed274e0a06bcbf62b1cd255e55f27368548f925ced9a5a',
     armv7l: '9fc1e546ec21478fb4ed274e0a06bcbf62b1cd255e55f27368548f925ced9a5a',
     x86_64: 'edb13970364eda495488af15f78716f4959fa907645574667ef9dddf5e3281cf'
  })

  depends_on 'perl_net_ssleay'
  depends_on 'perl_mozilla_ca'

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
