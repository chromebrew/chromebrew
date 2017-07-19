require 'package'

class Aprutil < Package
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'http://apr.apache.org/'
  version '1.6.0'
  source_url 'http://apache.claz.org/apr/apr-util-1.6.0.tar.bz2'
  source_sha256 '8474c93fa74b56ac6ca87449abe3e155723d5f534727f3f33283f6631a48ca4c'

  depends_on 'apr'

  def self.build
    system './configure --prefix=/usr/local --with-apr=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
