require 'buildsystems/rust'

class Edit < RUST
  description 'A simple editor for simple needs.'
  homepage 'https://github.com/microsoft/edit.'
  version '1.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/edit.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '468167bc33398704ac5dc4b83d13c3cbf53b0b602b8cb4f269f4e26db98ed65b',
     armv7l: '468167bc33398704ac5dc4b83d13c3cbf53b0b602b8cb4f269f4e26db98ed65b',
       i686: '8a2dc7f7872fafbe914fe2fb38312c857eb9e2adbc4c8ad4f07e9819e9dca0cd',
     x86_64: 'bae2c8b8c85170172a89ec44edfd7def43494e985fdbb81dd146de63cd02c488'
  })

  depends_on 'gcc_lib' # R

  rust_channel 'nightly'
end
