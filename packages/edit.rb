require 'buildsystems/rust'

class Edit < RUST
  description 'A simple editor for simple needs.'
  homepage 'https://github.com/microsoft/edit.'
  version '1.0.0-1cbb4cb'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/edit.git'
  # git_hashtag "v#{version.split('-').first}"
  git_hashtag '1cbb4cb1ad7a044eadb4cf49592d797266358951'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'ace7464220cf691e47b5c098cdd8fdf00126233e71c98ec898837845262e61ea',
     x86_64: '37f56b627af9e4673af20bd86df99b5e020bc2e711e98b3e06e3c6580126f77b'
  })

  depends_on 'gcc_lib' # R

  rust_channel 'nightly'
end
