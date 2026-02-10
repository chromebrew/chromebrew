# Adapted from Arch Linux rdfind PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=rdfind

require 'buildsystems/autotools'

class Rdfind < Autotools
  description 'Redundant data find - a program that finds duplicate files.'
  homepage 'https://rdfind.pauldreik.se/'
  version '1.7.0-1'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/pauldreik/rdfind.git'
  git_hashtag "releases/#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8c69c6491066c5ec4e4d03d93e8ad0b52f0ed860726fc30c6811a9640eb1ef8',
     armv7l: 'a8c69c6491066c5ec4e4d03d93e8ad0b52f0ed860726fc30c6811a9640eb1ef8',
       i686: '89b9632df969a15d3cf6004e8ba93ce79219a1b4f0e306c729cfb2e0e537b298',
     x86_64: '5fce0767f527c9f1f0af226aad64a21d992f9ed9dcfba497a180bfb18d33a2c7'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'nettle' # R
  depends_on 'xxhash' # R

  def self.patch
    system "sed -i '/<vector>/a #include <limits>' rdfind.cc"
    system "sed -i '/<cstdio>/a #include <stdexcept>' Checksum.cc"
  end
end
