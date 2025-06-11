require 'buildsystems/rust'

class Edit < RUST
  description 'A simple editor for simple needs.'
  homepage 'https://github.com/microsoft/edit'
  version '1.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/edit.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14e24a53daeefb85850b8ba4a8ab67c59b0da24bcfb7266f43f70f1d8c28cd00',
     armv7l: '14e24a53daeefb85850b8ba4a8ab67c59b0da24bcfb7266f43f70f1d8c28cd00',
       i686: '6a6dd916d54e402428f064a4e1dd8c33150ab9db68737690f8e9730138d9569c',
     x86_64: '25c47a29e12df6ff098c085d31f877724ee686f58bef55f83a511ec307e5a188'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  rust_channel 'nightly'
end
