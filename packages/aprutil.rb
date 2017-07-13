require 'package'

class Aprutil < Package
  description 'APR-util provides a number of helpful abstractions on top of APR.'
  homepage 'http://apr.apache.org/'
  version '1.5.4'
  source_url 'http://apache.claz.org//apr/apr-util-1.5.4.tar.gz'
  source_sha256 '976a12a59bc286d634a21d7be0841cc74289ea9077aa1af46be19d1a6e844c19'

  depends_on 'apr'

  def self.build
    system './configure --prefix=/usr/local --with-apr=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
