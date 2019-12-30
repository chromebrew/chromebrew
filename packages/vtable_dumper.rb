require 'package'

class Vtable_dumper < Package
  description 'A tool to list content of virtual tables in a shared library'
  homepage 'https://github.com/lvc/vtable-dumper'
  version '1.2'
  source_url 'https://github.com/lvc/vtable-dumper/archive/1.2.tar.gz'
  source_sha256 '6993781b6a00936fc5f76dc0db4c410acb46b6d6e9836ddbe2e3c525c6dd1fd2'

  binary_url ({
  })
  binary_sha256 ({
  })


  def self.build
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}"
  end

  def self.install
    system "install -Dm755 vtable-dumper #{CREW_DEST_PREFIX}/bin/vtable-dumper"
  end
end
