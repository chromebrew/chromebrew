require 'package'

class Libcyrussasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.27-rc6'
  source_url 'ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.27-rc6.tar.gz'
  source_sha256 'ff14faa7119149873d9fc2de8c8816af6522d1eeaf4a50a6afe4c414c19bcc4c'

  depends_on 'diffutils' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-shared',
           '--with-cxx-shared'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
