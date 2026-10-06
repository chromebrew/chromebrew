require 'buildsystems/rust'

class Rust_bindgen < RUST
  description 'bindgen automatically generates Rust FFI bindings to C (and some C++) libraries.'
  homepage 'https://github.com/rust-lang/rust-bindgen'
  version '0.73.2'
  license 'MPL2'
  compatibility 'all'
  source_url 'https://github.com/rust-lang/rust-bindgen.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '490d8a4dff347fe9b2e944842c36cd4813c8b883d17dfe6b3f0ba961bed16e83',
     armv7l: '490d8a4dff347fe9b2e944842c36cd4813c8b883d17dfe6b3f0ba961bed16e83',
       i686: 'f2fa9c1212ef4bbc6c80c1116c0e86c250252385db60ed50e2b13e4c2602be55',
     x86_64: '56d1f397949826126bb00e100f35ee6bb2360fad656c647df4914bce70c0aac0'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build

  rust_install_path 'bindgen-cli'
  rust_packages 'bindgen-cli'
end
