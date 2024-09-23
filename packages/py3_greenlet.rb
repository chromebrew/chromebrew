require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version '3.1.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '686ad1cfc8fb7cc30bd9c0bd6ac4670ebbc751a07e0c256b2ac5aca0756171b7',
     armv7l: '686ad1cfc8fb7cc30bd9c0bd6ac4670ebbc751a07e0c256b2ac5aca0756171b7',
       i686: '99b8013bcbc225c5caec586a8a43acf61f58024b769716ef3ab9394085ec72d2',
     x86_64: 'f8d7cf86010970d7082f5c4e5cdfe1b384f36d01a23342ff298d64439ee4f2c6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
