require 'package'

class Pacparser < Package
  description 'pacparser is a library to parse proxy auto-config (PAC) files.'
  homepage 'http://pacparser.manugarg.com/'
  version '1.3.7-1'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/pacparser/pacparser/archive/1.3.7.tar.gz'
  source_sha256 '575c5d8096b4c842b2af852bbb8bcfde96170b28b49f33249dbe2057a8beea13'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacparser/1.3.7-1_armv7l/pacparser-1.3.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacparser/1.3.7-1_armv7l/pacparser-1.3.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacparser/1.3.7-1_i686/pacparser-1.3.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacparser/1.3.7-1_x86_64/pacparser-1.3.7-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b5552a187ea7fdc2bdf7038e9af576b5dab3beb31e10be7f9fcf87345cad3269',
     armv7l: 'b5552a187ea7fdc2bdf7038e9af576b5dab3beb31e10be7f9fcf87345cad3269',
       i686: 'e19682f29ee5ee1671ede739a231a273e24f1d4e589c97db1661b38b02674145',
     x86_64: '19fba2248fd1de821160e42a66c01d5e9543e20996e4d6c4795a35d7325e3a65'
  })

  def self.build
    system 'make -j1 -C src'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} make -C src install"
  end
end
