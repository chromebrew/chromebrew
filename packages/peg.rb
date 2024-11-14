require 'package'

class Peg < Package
  description 'recursive-descent parser generators for C'
  homepage 'https://www.piumarta.com/software/peg/'
  version '0.1.20'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.piumarta.com/software/peg/peg-#{version}.tar.gz"
  source_sha256 'b8b717bc93a59768a35d6525679a4e0ce94e6bf66f92bacf2979c6474572b45a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '067774ea64597be22413a26404f82d807fdf7518971312739242d8dff0eedd61',
     armv7l: '067774ea64597be22413a26404f82d807fdf7518971312739242d8dff0eedd61',
       i686: '5be1892c37014891c67f32b2b5cd8933579f900f657695b8dfa33fed8fe7d61b',
     x86_64: '9e0f53922d97f1a3f9a7c6f76b5ad2dc4cb9eb3d6d1e238a3beb05a22c48a3b9'
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "MANDIR=#{CREW_MAN_PREFIX}/man1"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "MANDIR=#{CREW_DEST_MAN_PREFIX}/man1", "ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
