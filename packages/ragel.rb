require 'package'

class Ragel < Package
  description 'Ragel compiles executable finite state machines from regular languages.'
  homepage 'http://www.colm.net/open-source/ragel/'
  version '6.10'
  source_url 'https://www.colm.net/files/ragel/ragel-6.10.tar.gz'
  source_sha256 '5f156edb65d20b856d638dd9ee2dfb43285914d9aa2b6ec779dac0270cd56c3f'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
