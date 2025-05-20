require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "45.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7728f431a303989a47a7c226535ae7df519919bd123f825bc9560b992404eda2',
     armv7l: '7728f431a303989a47a7c226535ae7df519919bd123f825bc9560b992404eda2',
       i686: 'c92608b8551de0f82b66ade47cc15121e46a30aaa79f7a0bd872fd09dedfa772',
     x86_64: 'a0c75d402b75fc997b0a2be195a3fde475f6509cec5355f84e06ff7ebec440bb'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'rust' => :build

  no_source_build
end
