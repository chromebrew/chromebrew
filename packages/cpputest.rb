require 'package'

class Cpputest < Package
  description 'Unit testing and mocking framework for C/C++.'
  homepage 'https://cpputest.github.io/'
  version '3.8'
  source_url 'https://github.com/cpputest/cpputest/archive/v3.8.tar.gz'
  source_sha256 '2b95bb4a568f680cdcca678345a2c41c028275471c2ed7bf0b6f6f1f689c3b76'

  def self.build                   # the steps required to build the package
    system "./autogen.sh"
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install                 # the steps required to install the package
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check                   # the steps required to check if the package was built ok
    system "make", "check"
  end
end

