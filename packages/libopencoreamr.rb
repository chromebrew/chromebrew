require 'buildsystems/autotools'

class Libopencoreamr < Autotools
  description 'Audio codecs extracted from Android Open Source Project.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '0.1.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://git.code.sf.net/p/opencore-amr/code.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9a0134954eadfb1e307b7944928250d085e411e7bf3fc905aba9c9ca32ab74d',
     armv7l: 'f9a0134954eadfb1e307b7944928250d085e411e7bf3fc905aba9c9ca32ab74d',
       i686: 'd3c1da69262e96b5814c76c4c123c26e64999c8304bd318a5a3ccc819a49b948',
     x86_64: 'd2fe762393e469494f18897541a0b9c9fcddf5d8d6a8bd139fbad49c908b6b48'
  })

  depends_on 'glibc' # R
end
