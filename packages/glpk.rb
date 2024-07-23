require 'package'

class Glpk < Package
  description 'The GLPK (GNU Linear Programming Kit) package is intended for solving large-scale linear programming (LP), mixed integer programming (MIP), and other related problems.'
  homepage 'https://www.gnu.org/software/glpk/'
  version '5.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/glpk/glpk-5.0.tar.gz'
  source_sha256 '4a1013eebb50f728fc601bdd833b0b2870333c3b3e5a816eeba921d95bec6f15'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60ca5699473f9c67974f0567d1ff8453c3dd8cee7cab11398ea457ad472ef45a',
     armv7l: '60ca5699473f9c67974f0567d1ff8453c3dd8cee7cab11398ea457ad472ef45a',
       i686: '82f10794ee43f98d03b8bb1d163f9aa121d15b3af8b343613f69a0f5dfd49fdf',
     x86_64: 'c8daf55a17a122a0d6b0d3a7e0853e29adaa6ee96e9d9fda04105930b1fd77f9'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
