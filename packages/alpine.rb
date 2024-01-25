require 'package'

class Alpine < Package
  description 'The continuation of the Alpine email client from University of Washington.'
  homepage 'http://alpine.x10host.com/alpine'
  version '2.25'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'http://alpine.x10host.com/alpine/release/src/alpine-2.25.tar.xz'
  source_sha256 '658a150982f6740bb4128e6dd81188eaa1212ca0bf689b83c2093bb518ecf776'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c919cb0d6fad903fc0e0cb96f1d8bff6030181a9e871b38ccd59a121f342dfe',
     armv7l: '6c919cb0d6fad903fc0e0cb96f1d8bff6030181a9e871b38ccd59a121f342dfe',
       i686: '453a722ceefb5749a215e76599133686011b51c9b45a4747d5c95faf7f94f799',
     x86_64: '31d6176774aee2a53e8fd784816c7daaa361cf80c8ea8fa11f99c3fe22c3bfef'
  })

  depends_on 'e2fsprogs'
  depends_on 'hunspell_en_us'
  depends_on 'openldap'
  depends_on 'tcl' # R
  no_fhs # complains about /usr/local/tmp

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure \
           #{CREW_OPTIONS} \
           --with-ssl-dir=#{CREW_PREFIX}/etc/ssl \
           --with-ssl-include-dir=#{CREW_PREFIX}/include \
           --with-ssl-lib-dir=#{CREW_LIB_PREFIX} \
           --disable-nls \
           --with-system-pinerc=#{CREW_PREFIX}/etc/alpine.d/pine.conf \
           --with-system-fixed-pinerc=#{CREW_PREFIX}/etc/alpine/pine.conf.fixed"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
