require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.3.1-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://bigsearcher.com/mirrors/nongnu/acl/acl-2.3.1.tar.xz'
  source_sha256 'c0234042e17f11306c23c038b08e5e070edb7be44bef6697fb8734dcff1c66b1'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1-1_armv7l/acl-2.3.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1-1_armv7l/acl-2.3.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1-1_i686/acl-2.3.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1-1_x86_64/acl-2.3.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd0c1f4730b03f83d15867b9a71b4dbf1ed27f03e2029a052e50b3da854c597bf',
     armv7l: 'd0c1f4730b03f83d15867b9a71b4dbf1ed27f03e2029a052e50b3da854c597bf',
       i686: 'a09785c84da91c6869db8ca47c295bde5cdd69982854c6edadf3fe975652cd75',
     x86_64: '68f41aa3f486043fe7979efdce5348e414a643a908cf2483b179623a4ca1c179'
  })

  depends_on 'attr'
  no_zstd

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
