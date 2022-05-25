require 'package'

class Genstats < Package
  description 'genstats is a general statistics generator.'
  homepage 'https://www.vanheusden.com/genstats/'
  version '1.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.vanheusden.com/genstats/genstats-1.2.tgz'
  source_sha256 'f0fb9f29750cdaa85dba648709110c0bc80988dd6a98dd18a53169473aaa6ad3'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/genstats/1.2_armv7l/genstats-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/genstats/1.2_armv7l/genstats-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/genstats/1.2_i686/genstats-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/genstats/1.2_x86_64/genstats-1.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'de63231c25a96d3941458ccaeff027d4183570ab7734948159ba24bae6df54f9',
     armv7l: 'de63231c25a96d3941458ccaeff027d4183570ab7734948159ba24bae6df54f9',
       i686: 'e7db2eb7b5c59b2c36454a45fdb5bf5a26b69cc1a5ec54fb224fbcde68e376ad',
     x86_64: 'f138991b7ce736c6b9728ed41acd8b52bb09c133cfea78bdce3b01388323cdae'
  })

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 genstats #{CREW_DEST_PREFIX}/bin/genstats"
    system "install -Dm644 genstats.1 #{CREW_DEST_PREFIX}/share/man/man1/genstats.1"
  end
end
