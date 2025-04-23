require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac969ccbb17b98631b570a2b08f92de68f33715ed341118fef3c55d83bdeec3a',
     armv7l: 'ac969ccbb17b98631b570a2b08f92de68f33715ed341118fef3c55d83bdeec3a',
       i686: '25fd6836b5d61aa097698493a5d9e047bcfb72a0398cdf58c3c3031961f8fb00',
     x86_64: 'f8d7cf86010970d7082f5c4e5cdfe1b384f36d01a23342ff298d64439ee4f2c6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
