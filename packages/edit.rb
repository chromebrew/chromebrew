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
     x86_64: '73018cdec23432c117a4ff891cdd254aa162d2306d5e6eb84c353c3bc9d956f2'
  })

  depends_on 'gcc_lib' # R

  rust_channel 'nightly'
end
