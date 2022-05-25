# Adapted from Arch Linux peg PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/peg/trunk/PKGBUILD

require 'package'

class Peg < Package
  description 'recursive-descent parser generators for C'
  homepage 'https://www.piumarta.com/software/peg/'
  version '0.1.18-2'
  license 'MIT'
  compatibility 'all'
  source_url 'http://piumarta.com/software/peg/peg-0.1.18.tar.gz'
  source_sha256 '20193bdd673fc7487a38937e297fff08aa73751b633a086ac28c3b34890f9084'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peg/0.1.18-2_armv7l/peg-0.1.18-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peg/0.1.18-2_armv7l/peg-0.1.18-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peg/0.1.18-2_i686/peg-0.1.18-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peg/0.1.18-2_x86_64/peg-0.1.18-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '439a168668877cae8de48cf51c9f18c18245373a6c7e7104c8fa23d61197264f',
     armv7l: '439a168668877cae8de48cf51c9f18c18245373a6c7e7104c8fa23d61197264f',
       i686: '584696fc71b9e3dee4f1beb736ce88e9d5cd9e7d508c431c0e94c0092c809518',
     x86_64: 'eb2da8d54a121265fabae9af1e30f9a5e4d89461e4e39477971a7fbc1b22d458'
  })

  def self.build
    system "sed -i 's,PREFIX = /usr/local,PREFIX = #{CREW_PREFIX},g' Makefile"
    system 'make'
  end

  def self.install
    system "make ROOT=#{CREW_DEST_DIR} install"
  end
end
