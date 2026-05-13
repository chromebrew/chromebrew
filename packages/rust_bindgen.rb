require 'buildsystems/rust'

class Rust_bindgen < RUST
  description 'bindgen automatically generates Rust FFI bindings to C (and some C++) libraries.'
  homepage 'https://github.com/rust-lang/rust-bindgen'
  version '0.72.1'
  license 'MPL2'
  compatibility 'all'
  source_url 'https://github.com/rust-lang/rust-bindgen.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a21601070721d2a2985e34f44571fbeb7387ca11ca117e5283f6d8ef6d46eba4',
     armv7l: 'a21601070721d2a2985e34f44571fbeb7387ca11ca117e5283f6d8ef6d46eba4',
       i686: 'ef03597cccb229e1a534b6de81aaf85d07129bbc88a94bcc49de86572e41f92e',
     x86_64: 'c2e5736fe5d310f261da6f289490f3e5dfca3bb5e2ea53ed0193655ca45fb632'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build

  rust_install_path 'bindgen-cli'
  rust_packages 'bindgen-cli'
end
