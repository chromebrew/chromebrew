require 'buildsystems/pip'

class Py3_scons < Pip
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.10.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f3171ec6f6503dcfedc593f150f65e547c392ce48d84c3ec9b01eb456314a4a',
     armv7l: '5f3171ec6f6503dcfedc593f150f65e547c392ce48d84c3ec9b01eb456314a4a',
       i686: '282fba9583ce3404692223a84e7fcf0531fb16acdff68bb5307da31cd2ad4934',
     x86_64: 'be69ff1da1d5e13461856345b9821e7923308e2deabca0f8fb7d140b7cc28350'
  })

  depends_on 'python3' # R
  no_source_build
end
