# Adapted from Arch Linux time PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/time/trunk/PKGBUILD

require 'package'

class Gnu_time < Package
  description 'Utility for monitoring a programs use of system resources'
  homepage 'https://www.gnu.org/software/time/'
  version '1.9'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/time.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnu_time/1.9_i686/gnu_time-1.9-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnu_time/1.9_armv7l/gnu_time-1.9-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnu_time/1.9_armv7l/gnu_time-1.9-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnu_time/1.9_x86_64/gnu_time-1.9-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: 'be10181fa1e78fbbadd2fcdd7b8d6ecd71cdd8d38b1e521f400a93b3376f98a3',
    aarch64: '91fada2df988370b67ff384fbd18e002f9123f69debdb9184dacdd231afd1924',
     armv7l: '91fada2df988370b67ff384fbd18e002f9123f69debdb9184dacdd231afd1924',
     x86_64: 'f042a1fe4d36029d2cc90a79bdc4014c0b6324008bbc971d35fb0001216a2562'
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
