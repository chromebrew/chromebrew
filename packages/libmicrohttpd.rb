require 'package'

class Libmicrohttpd < Package
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '0.9.75'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-0.9.75.tar.gz'
  source_sha256 '9278907a6f571b391aab9644fd646a5108ed97311ec66f6359cebbedb0a4e3bb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '206d5948a84b2c884464c974764806441076c64db7ce6c887cc4af3f33683950',
     armv7l: '206d5948a84b2c884464c974764806441076c64db7ce6c887cc4af3f33683950',
       i686: 'beaaf1d4036354f8cf5b38e157816f151777c6a9fdfad6b1c88b9c0a3dd61303',
     x86_64: 'f9d2926975d54adbf19858c8b2a2cb9b6e20368301a24aa168f7a10ec3228717'
  })

  depends_on 'diffutils' => :build
  depends_on 'glibc' # R
  depends_on 'gnutls' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
