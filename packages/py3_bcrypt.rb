require 'buildsystems/pip'

class Py3_bcrypt < Pip
  description 'Modern password hashing for your software and your servers.'
  homepage 'https://github.com/pyca/bcrypt/'
  version "5.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6606c8f9b64b344029a3ca21a6bb113844fe1bb5cf5f8c6779d010059b0415b5',
     armv7l: '6606c8f9b64b344029a3ca21a6bb113844fe1bb5cf5f8c6779d010059b0415b5',
       i686: 'ff0387d23f2fc0fb66cb893755fba552835e4dccdf33b2bb5897dcc27171cf55',
     x86_64: '78298ec564ad3eab231be6112e6dea340bb27c79bf003226d78a5b595a7657f8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3'
  depends_on 'rust' => :build

  no_source_build
end
