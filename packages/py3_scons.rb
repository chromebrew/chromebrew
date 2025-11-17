require 'buildsystems/pip'

class Py3_scons < Pip
  description 'SCons is an Open Source software construction tool that is, a next-generation build tool.'
  homepage 'https://scons.org/'
  license 'MIT'
  version '4.10.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f2a9f5075e0e5f0dcdb229b831e1e7dc823c5f010bbc4bd99dc0763944435eee',
     armv7l: 'f2a9f5075e0e5f0dcdb229b831e1e7dc823c5f010bbc4bd99dc0763944435eee',
       i686: '1261be31114700c390c6123f57ed1d5a2b370ff1f264454434f9159f47755084',
     x86_64: '793d922cb2634d6fb41bf99df846ae6fd494983acacf3fa2e1c26c469e5dfa5b'
  })

  depends_on 'python3' # R
  no_source_build
end
