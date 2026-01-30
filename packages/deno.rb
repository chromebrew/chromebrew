# Adapted from Arch Linux deno PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/deno/trunk/PKGBUILD

require 'buildsystems/rust'

class Deno < RUST
  description 'A secure runtime for JavaScript and TypeScript'
  homepage 'https://deno.land'
  version '2.6.7'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/denoland/deno.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '4e1b41af08de40c2696f2386712a217c8a96452cf072f5ca042a85aa8cef7ecd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build
  depends_on 'protobuf' => :build

  def self.install
    FileUtils.install 'target/release/deno', "#{CREW_DEST_PREFIX}/bin/deno", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions"
    system "./target/release/deno completions bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/deno"
  end
end
