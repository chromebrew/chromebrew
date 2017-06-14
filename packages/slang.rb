require 'package'

class Slang < Package
  description 'S-Lang is a multi-platform programmer\'s library designed to allow a developer to create robust multi-platform software.'
  homepage 'http://www.jedsoft.org/slang/'
  version '2.3.1a'
  source_url 'http://www.jedsoft.org/releases/slang/slang-2.3.1a.tar.bz2'
  source_sha1 'a8ea7f1b5736160a94efb67b137a0f5b9916bdf2'

  def self.build
    system "./configure", "--prefix=/usr/local", "--without-x"

    # force to compile in sequential since slang Makefile doesn't work in parallel
    system "make", "-j1"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
