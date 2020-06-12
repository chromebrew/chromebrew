require 'package'

class Perl_io_socket_ssl < Package
  description 'IO::Socket::SSL - SSL sockets with IO::Socket interface'
  homepage 'https://metacpan.org/pod/IO::Socket::SSL'
  version '2.060'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-2.060.tar.gz'
  source_sha256 'fb5b2877ac5b686a5d7b8dd71cf5464ffe75d10c32047b5570674870e46b1b8c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.060-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.060-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.060-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_io_socket_ssl-2.060-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3a53e101598580430bacbb43d7aa785132e5caa9e01f904931cf9b78655bc98e',
     armv7l: '3a53e101598580430bacbb43d7aa785132e5caa9e01f904931cf9b78655bc98e',
       i686: '8c375d51e437ddf009c08f4fe94f343e637e5ec908c620bda70d14a3a0f3d461',
     x86_64: '821a9cb6261699a5d81069540971f42c4a4a2e7dfc46b92bea7b093e47653d17',
  })

  depends_on 'perl'

  def self.build
    system "yes | perl Makefile.PL PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
    system 'make'
  end

  def self.install
    system 'make', 'install'
  end
end
