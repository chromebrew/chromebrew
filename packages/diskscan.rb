require 'package'

class Diskscan < Package
  description 'diskscan is intended to find sectors of a storage medium (hard disk, flash drive or pendrive, etc.) which are bad or in the process of going bad.'
  homepage 'http://blog.disksurvey.org/proj/diskscan/'
  version '0.19'
  source_url 'https://github.com/baruch/diskscan/archive/0.19.tar.gz'
  source_sha256 '92a7298af99043e1e584e4343040b6574b9229f44c122e1cbcb90ba478d928d1'

  depends_on 'cmake'
  depends_on 'termcap'

  def self.build
    system "cmake ."
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
