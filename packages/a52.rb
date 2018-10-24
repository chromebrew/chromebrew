require 'package'

class A52 < Package
  description 'liba52 is a free library for decoding ATSC A/52 streams.'
  homepage 'http://liba52.sourceforge.net/'
  version '0.7.4'
  source_url 'http://liba52.sourceforge.net/files/a52dec-0.7.4.tar.gz'
  source_sha256 'a21d724ab3b3933330194353687df82c475b5dfb997513eef4c25de6c865ec33'

  def self.build
    system "./bootstrap"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
