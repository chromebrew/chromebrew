# Adapted from Arch Linux time PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/time/trunk/PKGBUILD

require 'package'

class Gnu_time < Package
  description 'Utility for monitoring a programs use of system resources'
  homepage 'https://www.gnu.org/software/time/'
  version '1.9-59f462a'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/time.git'
  git_hashtag '59f462a2ed5e7f073cfc9c509d3e2dec438b2681'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08d1098eaa5dffcbd0d9931cae419f0f42a225f6cd275b5f59f07552bfd5cafa',
     armv7l: '08d1098eaa5dffcbd0d9931cae419f0f42a225f6cd275b5f59f07552bfd5cafa',
       i686: '0dd61bd97400d05ad8a99ce53f2e7184a9f0404b268ed5ab565167f2aaee162e',
     x86_64: 'a2d83343217b858ebed7e290af9df06338fa30111f5ef6afdd3473046f631242'
  })

  depends_on 'glibc'

  def self.patch
    system "sed -i 's,/build-aux,,' .gitignore"
  end

  def self.build
    system './bootstrap --no-git --gnulib-srcdir=./gnulib'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} --infodir=#{CREW_PREFIX}/share/info"
    system 'make'
  end

  def self.install
    system "make exec_prefix=#{CREW_DEST_PREFIX} infodir=#{CREW_DEST_PREFIX}/share/info install"
  end
end
