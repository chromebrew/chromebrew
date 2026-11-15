require 'buildsystems/autotools'

class Rdfind < Autotools
  description 'Redundant data find - a program that finds duplicate files.'
  homepage 'https://rdfind.pauldreik.se/'
  version '1.8.0'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/pauldreik/rdfind.git'
  git_hashtag "releases/#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf6870de60995f62b36a96baa20868901ac3bf75faf976f0dfcc36a22db1a8f4',
     armv7l: 'cf6870de60995f62b36a96baa20868901ac3bf75faf976f0dfcc36a22db1a8f4',
       i686: 'cfb0177d2c3de2b880c802b1bf057f889328a4b4b03e36dd2e8565164b88b0fb',
     x86_64: '7aaeadaf82cd766f26c1dbcb79f5471cf6ce16e4d4576c44ed1c6ae032f40c24'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'nettle' => :executable
  depends_on 'xxhash' => :executable

  def self.patch
    system "sed -i '/<vector>/a #include <limits>' rdfind.cc"
    system "sed -i '/<cstdio>/a #include <stdexcept>' Checksum.cc"
  end
end
