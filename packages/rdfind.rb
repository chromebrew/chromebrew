# Adapted from Arch Linux rdfind PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=rdfind

require 'buildsystems/autotools'

class Rdfind < Autotools
  description 'Redundant data find - a program that finds duplicate files.'
  homepage 'https://rdfind.pauldreik.se/'
  version '1.7.0-1ed3036'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/pauldreik/rdfind.git'
  git_hashtag '1ed3036a133037c4a32b99f960177f9774495f74'
  # git_hashtag "releases/#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ae9197eb83e4b11cb03fefc8dd8dc4cc8f8ec1186821874b10ddc456416befa',
     armv7l: '0ae9197eb83e4b11cb03fefc8dd8dc4cc8f8ec1186821874b10ddc456416befa',
       i686: '8906db22f0dcca36ca4938cedcb4374c0e9f3402bad72f46a93082e28fc6ac4d',
     x86_64: 'e4782a1446cbf734a3794e0ceb88b842c708e177c1128724576f03611e3b68ce'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'nettle' => :executable_only
  depends_on 'xxhash' => :executable_only

  def self.patch
    system "sed -i '/<vector>/a #include <limits>' rdfind.cc"
    system "sed -i '/<cstdio>/a #include <stdexcept>' Checksum.cc"
  end
end
