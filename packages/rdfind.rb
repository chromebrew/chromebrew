# Adapted from Arch Linux rdfind PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=rdfind

require 'package'

class Rdfind < Package
  description 'Redundant data find - a program that finds duplicate files.'
  homepage 'http://rdfind.pauldreik.se'
  version '1.6.0'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/pauldreik/rdfind.git'
  git_hashtag "releases/#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ca9417e258b5ff07bf3a102278e9b963656c443478b2aeec1eb8cba3361d5e1',
     armv7l: '4ca9417e258b5ff07bf3a102278e9b963656c443478b2aeec1eb8cba3361d5e1',
       i686: '6c6af3b3f4628b9a7aa8c427d2673ef7b3122343f555646895337727437a126f',
     x86_64: '741d44e5fe82ac4a791f09fe7fa019c8398cea277c764221d8f178d33f897eb3'
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
