require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0798e7a5d9056f367c4a0696481c4ce9c2a3c0ac409ecc19a5514320806989f',
     armv7l: 'f0798e7a5d9056f367c4a0696481c4ce9c2a3c0ac409ecc19a5514320806989f',
       i686: '1ad0d6c504a7ef5e920fe45d7d9bd9ebc3575553e28c19aafd92915358f980b0',
     x86_64: 'f1ff2338a9ea4b80f9b793321cbba28ae0def7b1804eae42fffe76f888bd6e98'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
