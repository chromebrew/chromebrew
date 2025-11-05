require 'buildsystems/rust'

class Edit < RUST
  description 'A simple editor for simple needs.'
  homepage 'https://github.com/microsoft/edit'
  version '1.2.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/edit.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31ce1e9925dded90169f46ba07b7cb324c77981ebe44910ce44556361dcf8ce1',
     armv7l: '31ce1e9925dded90169f46ba07b7cb324c77981ebe44910ce44556361dcf8ce1',
       i686: '1e5c2bf3970c1e8df1b7ea724707a404f448042f5935d20adb11318021d9aaa9',
     x86_64: '1bee42d4b0f48e0b8ce76cdeeb50fde5514798f3e6d4b3441f28978e8c232c15'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  rust_channel 'nightly'
end
