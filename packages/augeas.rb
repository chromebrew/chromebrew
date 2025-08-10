require 'buildsystems/autotools'

class Augeas < Autotools
  description 'Augeas is a configuration editing tool that parses native formats and transforms them into a tree.'
  homepage 'http://augeas.net/'
  version '1.14.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hercules-team/augeas.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9dd7440cce4c14974d16067391c94e1843e95f97f365417a072f67f0b8942c2',
     armv7l: 'e9dd7440cce4c14974d16067391c94e1843e95f97f365417a072f67f0b8942c2',
       i686: 'b96ac5006edaf4bf7798780e8d79d2dffeb65e72776f7122b41d7df49ba03672',
     x86_64: 'aec53220195d0b711d890c282c4babcc2ee546da79858efa815186a23bfee61c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
