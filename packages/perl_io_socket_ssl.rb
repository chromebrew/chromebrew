require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.068-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.068.tar.gz'
  source_sha256 '4420fc0056f1827b4dd1245eacca0da56e2182b4ef6fc078f107dc43c3fb8ff9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.068-1_armv7l/perl_io_socket_ssl-2.068-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.068-1_armv7l/perl_io_socket_ssl-2.068-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.068-1_i686/perl_io_socket_ssl-2.068-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_io_socket_ssl/2.068-1_x86_64/perl_io_socket_ssl-2.068-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8c2230feb2b7205349703e5b5b5b10e9f21f3ce079e5b6036728c33ee91a1ff6',
     armv7l: '8c2230feb2b7205349703e5b5b5b10e9f21f3ce079e5b6036728c33ee91a1ff6',
       i686: '24df6cac573463073b723da4b9b1a65380e2cdd67a053aabb9e61491410960c7',
     x86_64: 'd753d89a94d4a9538bf576040e00b3216b1746a9930e091a60366f2627978fc4'
  })

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
