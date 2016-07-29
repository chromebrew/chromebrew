require 'package'

class Unzip < Package
  version '6.0'
  source_url 'http://pkgs.fedoraproject.org/repo/pkgs/unzip/unzip60.tar.gz/62b490407489521db863b523a7f86375/unzip60.tar.gz'
  source_sha1 'abf7de8a4018a983590ed6f5cbd990d4740f8a22'

  depends_on 'buildessential'

  def self.build
    system "make -f unix/Makefile generic"
  end

  def self.install
    system "make prefix=/usr/local MANDIR=/usr/local/tmp/unzip-man -f unix/Makefile install"
    #remove the man pages we couldn't install
    system "rm -r -f /usr/local/tmp/unzipman"
  end
end
