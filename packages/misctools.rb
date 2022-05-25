require 'package'

class Misctools < Package
  description 'The misctools package is a collection of small but useful utilities.'
  homepage 'http://www.hyperrealm.com/oss_misctools.shtml'
  version '2.6'
  license 'GPL-2'
  compatibility 'i686,x86_64'
  source_url 'http://www.hyperrealm.com/packages/misctools-2.6.tar.bz2'
  source_sha256 'b1f13bb3af52ffffddf45efd8c10f942a8c1548352b7878668fbbf27ffa68e1a'
  binary_compression 'tar.xz'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/misctools/2.6_i686/misctools-2.6-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/misctools/2.6_x86_64/misctools-2.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: 'fca8249a6a8908228fb298e0b5b71d2f9030acf07a56438217d6d9a3576250a5',
    x86_64: '71110f615c2a068066ac8761f6aecde557464946d3cf75a5420a1ee8f2ec14d1'
  })

  depends_on 'cbase'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
