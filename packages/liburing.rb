require 'package'

class Liburing < Package
  description 'liburing provides helpers to setup and teardown io_uring instances.'
  homepage 'https://github.com/axboe/liburing/'
  version '0.7'
  compatibility 'all'
  source_url 'https://github.com/axboe/liburing/archive/liburing-0.7.tar.gz'
  source_sha256 '8e2842cfe947f3a443af301bdd6d034455536c38a455c7a700d0c1ad165a7543'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --mandir=#{CREW_MAN_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
