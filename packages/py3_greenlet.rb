require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.5.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c66c6720630b1ce2909ed96341ac9084835e789d9bb3306767b67ef5e0e20ccf',
     armv7l: 'c66c6720630b1ce2909ed96341ac9084835e789d9bb3306767b67ef5e0e20ccf',
       i686: '710aa6058dd3eb47626fe1471f46218e290ddd99dd2fabf9c58203694df25c01',
     x86_64: '7eae9ee7015b8eb850053aedb1a892b0df40a30b83bf89d4427dfa4320341a92'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :logical

  no_source_build
end
