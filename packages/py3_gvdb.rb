require 'buildsystems/pip'

class Py3_gvdb < Pip
  description 'Python client for GVDB distributed vector database'
  homepage 'https://github.com/JonathanBerhe/gvdb'
  version "0.34.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d68e23536ceab556ad60b0a880730368bbeeaafe9c48cbbd4e6c25ddeb90bae',
     armv7l: '4d68e23536ceab556ad60b0a880730368bbeeaafe9c48cbbd4e6c25ddeb90bae',
       i686: '0940812fe4ea18ad423799712288b5bc3063575bd26ee6dcc0d5016017af62e9',
     x86_64: '24283c2b6f8c6a3a33bdb75351b9e66fecdc7de4ef29a9097040d72f8bac5a80'
  })

  depends_on 'python3' => :logical

  no_source_build
end
