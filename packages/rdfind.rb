# Adapted from Arch Linux rdfind PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=rdfind

require 'package'

class Rdfind < Package
  description 'Redundant data find - a program that finds duplicate files.'
  homepage 'http://rdfind.pauldreik.se'
  version '1.4.1-fa77'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/pauldreik/rdfind.git'
  git_hashtag 'fa7752d6205e2071a758e7aa2d4e1c541aa96a6e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.4.1-fa77_armv7l/rdfind-1.4.1-fa77-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.4.1-fa77_armv7l/rdfind-1.4.1-fa77-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.4.1-fa77_i686/rdfind-1.4.1-fa77-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.4.1-fa77_x86_64/rdfind-1.4.1-fa77-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '323a416209cbe8c2e49bc56d2abf61a5c2bb01df8f8ec0fb4935b269dff77b1e',
     armv7l: '323a416209cbe8c2e49bc56d2abf61a5c2bb01df8f8ec0fb4935b269dff77b1e',
       i686: 'af95b9800f9eb6c8695cc23e3f2ee761c1fafc461b2e296b7ac39d84ac8c04b6',
     x86_64: '2b442e00f36840cea9c023a4ffad71aa8952df831769594759726bd5f24372f4'
  })

  def self.patch
    system "sed -i '/<vector>/a #include <limits>' rdfind.cc"
    system "sed -i '/<cstdio>/a #include <stdexcept>' Checksum.cc"
  end

  def self.build
    system '[ -x configure ] || autoreconf -fvi'
    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS}"
    system 'make -s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
