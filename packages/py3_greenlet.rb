require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version '3.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbbbe875271df36fb53cea0ee1d73a25b96d62b851c919e0812fe8e11adaabdc',
     armv7l: 'bbbbe875271df36fb53cea0ee1d73a25b96d62b851c919e0812fe8e11adaabdc',
       i686: '55128e14f3bf4692025639fd9496c35e35486cdc1fd0e1e59471c3a55c52dd75',
     x86_64: '3350e5a95c18998e099bff279a8af3985d05fd7f405b270825bdb75c70d1f277'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
