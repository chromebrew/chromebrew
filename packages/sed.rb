require 'buildsystems/autotools'

class Sed < Autotools
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.9-b4d01a9'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/sed.git'
  git_hashtag 'b4d01a9c9174b514fd9ccac50f6e7990a1e86fbe'
  # source_url "https://ftpmirror.gnu.org/sed/sed-#{version.split('-').first}.tar.lz"
  # source_sha256 '6e226b732e1cd739464ad6862bd1a1aba42d7982922da7a53519631d24975181'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95b4f7db1c34826159e39f9d604af322f31c92f37ba9b7ce2967023080eaa61d',
     armv7l: '95b4f7db1c34826159e39f9d604af322f31c92f37ba9b7ce2967023080eaa61d',
       i686: 'd86bfd2d533b0f3f47bbf33f5c9d4a24c3f5fae31db4869a4c967964e0b5b17d',
     x86_64: '545c56168809e37a8c84381ad16905775def14949a09595453fc8ee5ffe7e0fc'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'glibc' # R
  depends_on 'wget2' => :build

  autotools_configure_options '--without-selinux \
                               --enable-gcc-warnings=no'
end
