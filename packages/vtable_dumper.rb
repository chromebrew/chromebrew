require 'package'

class Vtable_dumper < Package
  description 'A tool to list content of virtual tables in a shared library'
  homepage 'https://github.com/lvc/vtable-dumper'
  version '1.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/lvc/vtable-dumper/archive/1.2.tar.gz'
  source_sha256 '6993781b6a00936fc5f76dc0db4c410acb46b6d6e9836ddbe2e3c525c6dd1fd2'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '125f1d0739c19d226753e5d6e464376af7eefb79a3e50058e242599ec53f2b51',
     armv7l: '125f1d0739c19d226753e5d6e464376af7eefb79a3e50058e242599ec53f2b51',
       i686: '3c5f2ef1a858febb6691598d5abfdcf29982f3a899bd7f04b8e49a8999f20e65',
     x86_64: 'fa3de2338008e09bf9f7ad0e69ead44987bb6879e05480c61c61f52f3a57e8e1'
  })

  def self.build
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}"
  end

  def self.install
    system "install -Dm755 vtable-dumper #{CREW_DEST_PREFIX}/bin/vtable-dumper"
  end
end
