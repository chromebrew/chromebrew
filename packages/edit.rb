require 'buildsystems/rust'

class Edit < RUST
  description 'A simple editor for simple needs.'
  homepage 'https://github.com/microsoft/edit'
  version '1.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/edit.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '771cae3efe1afa52aef44c5f30a30ddc9420e9d22a3480bb1ae22dbb1a181191',
     armv7l: '771cae3efe1afa52aef44c5f30a30ddc9420e9d22a3480bb1ae22dbb1a181191',
       i686: '560f03e9dfe5a2ae2e10c677ca99ca34282d12b7c9035595afb946e9ad1b9465',
     x86_64: 'b64eceb2e051b9621b4c61caa6c5221c70e948d6e7d6a3f01138ed1f2bac3b32'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  rust_channel 'nightly'
end
