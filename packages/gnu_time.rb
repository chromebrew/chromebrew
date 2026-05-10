# Adapted from Arch Linux time PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/time/trunk/PKGBUILD

require 'package'

class Gnu_time < Package
  description 'Utility for monitoring a programs use of system resources'
  homepage 'https://www.gnu.org/software/time'
  version '1.10'
  license 'GPL'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/time.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8017ea28ece3abc79c1410a73f93668bd9a39f789059acad0952c44c5a4610a2',
     armv7l: '8017ea28ece3abc79c1410a73f93668bd9a39f789059acad0952c44c5a4610a2',
       i686: '1f58fa63eab4d9b7777f49ac8516797b221e349637796c2ca7cf0a3d2a420bf5',
     x86_64: '162374ee89f3ed9b17a91e4f72701b6695de039184af87452528e62f3380c25a'
  })

  depends_on 'glibc'
  depends_on 'glibc' => :executable

  def self.patch
    system "sed -i 's,/build-aux,,' .gitignore"
  end

  def self.build
    system './bootstrap --no-git --gnulib-srcdir=./gnulib'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_CONFIGURE_OPTIONS} --infodir=#{CREW_PREFIX}/share/info"
    system 'make'
  end

  def self.install
    system "make exec_prefix=#{CREW_DEST_PREFIX} infodir=#{CREW_DEST_PREFIX}/share/info install"
  end
end
