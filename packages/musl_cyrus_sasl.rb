require 'package'

class Musl_cyrus_sasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.27'
  compatibility 'all'
  license 'custom'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz'
  source_sha256 '26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '2821b2a97fddab00c8cb159f5c4dc85595a6567c0b3ec83c37f4e7ff3afdfade',
     armv7l: '2821b2a97fddab00c8cb159f5c4dc85595a6567c0b3ec83c37f4e7ff3afdfade',
       i686: 'ef815038d7ebc675b8a7e4e0f89b35ee50ff7da31c6e11cd9142eaedd8ab9b12',
     x86_64: '99ee11da56be7a4e82191b4875b1e5eda36956ba5c9765d41cc4d64e577412db'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_ncurses' => :build
  depends_on 'musl_openssl' => :build
  depends_on 'musl_krb5' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --enable-static \
        --with-cxx-static"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
