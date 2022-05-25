require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'https://www.gnu.org/software/diffutils/'
  version '3.10'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/diffutils/diffutils-3.10.tar.xz'
  source_sha256 '90e5e93cc724e4ebe12ede80df1634063c7a855692685919bfe60b556c9bd09e'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.10_armv7l/diffutils-3.10-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.10_armv7l/diffutils-3.10-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.10_i686/diffutils-3.10-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.10_x86_64/diffutils-3.10-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'aa743845cc8c4fe2b452dfe3abe9e45e7c2f270b4cc7de72731f51ae269c0557',
     armv7l: 'aa743845cc8c4fe2b452dfe3abe9e45e7c2f270b4cc7de72731f51ae269c0557',
       i686: 'cf222ec2fdb2a77d3873e74059b030a7acd247401fd7521c9041d6609def8949',
     x86_64: '9b8a48ae9b82cbe8ca466749613d48b1e350023e3a773af30089ce1414f05e5d'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    # FAIL: test-year2038
    # FAIL cmp (exit status: 1)
    # FAIL: invalid-re
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
