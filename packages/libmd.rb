require 'buildsystems/autotools'

class Libmd < Autotools
  description 'libmd provides message digest functions found on BSD systems.'
  homepage 'https://www.hadrons.org/software/libmd/'
  version '1.2.0'
  license 'BSD-3, BSD-2, ISC, Beerware, public-domain'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libmd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4420e98e843d87743e72c1a65bd44661b65248e02cf7c61e016215c9be73e53a',
     armv7l: '4420e98e843d87743e72c1a65bd44661b65248e02cf7c61e016215c9be73e53a',
       i686: '1b2d97d8a5dab22921f831040dafbaf2b6f6c2b1c89095534afb8a0c430badfc',
     x86_64: '631ecf25882cd2cf44a5be2727b45b94f7a32588cfda6249d13536c7e6efa49a'
  })

  depends_on 'glibc' => :library
end
