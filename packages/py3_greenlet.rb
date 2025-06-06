require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71614c965ba72a8f49c0bbf402819617c6c6ff50f69f23f21e8d8ff6bfec553d',
     armv7l: '71614c965ba72a8f49c0bbf402819617c6c6ff50f69f23f21e8d8ff6bfec553d',
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
