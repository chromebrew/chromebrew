# Adapted from Arch Linux rdfind PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=rdfind

require 'package'

class Rdfind < Package
  description 'Redundant data find - a program that finds duplicate files.'
  homepage 'http://rdfind.pauldreik.se'
  version '1.5.0'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/pauldreik/rdfind.git'
  git_hashtag "releases/#{version}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.5.0_armv7l/rdfind-1.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.5.0_armv7l/rdfind-1.5.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.5.0_i686/rdfind-1.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rdfind/1.5.0_x86_64/rdfind-1.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5147ee21271d6210ed3f826d3c7e7175501a4100d5cb6898310cefc518f5b68f',
     armv7l: '5147ee21271d6210ed3f826d3c7e7175501a4100d5cb6898310cefc518f5b68f',
       i686: '7e9c7393fd554211dd7a0d46fa524051254d5f118377e7705a26214b1a880610',
     x86_64: 'cc92cc6ed55717ba3dabe7160e82fa668e29f71364ff736cbc9004d61777f3ae'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nettle' # R

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
