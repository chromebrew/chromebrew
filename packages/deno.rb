# Adapted from Arch Linux deno PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/deno/trunk/PKGBUILD

require 'buildsystems/rust'

class Deno < RUST
  description 'A secure runtime for JavaScript and TypeScript'
  homepage 'https://deno.land'
  version '2.8.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/denoland/deno.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'cac4e2c93fa663bb743fc064240fb9166f3b24da23d6b7d35d98b9dca4ad6f94'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'protobuf' => :build

  def self.install
    FileUtils.install 'target/release/deno', "#{CREW_DEST_PREFIX}/bin/deno", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/bash-completion/completions"
    system "./target/release/deno completions bash > #{CREW_DEST_PREFIX}/share/bash-completion/completions/deno"
  end
end
