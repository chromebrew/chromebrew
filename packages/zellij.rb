# Adapted from Arch Linux zellij PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=zellij

require 'buildsystems/rust'

class Zellij < RUST
  description 'A terminal multiplexer'
  homepage 'https://zellij.dev'
  version '0.44.0'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/zellij-org/zellij.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: 'f91f01ce832fff4f9d243b123cf94fa190754a9ee2867f4d12d3cff6aa068447'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'protobuf' => :build
  depends_on 'rust' => :build
  depends_on 'zlib' => :library

  rust_targets 'wasm32-wasip1'

  rust_build_extras do
    system './target/release/zellij setup --generate-auto-start bash > target/bash.d.zellij'
    system './target/release/zellij setup --generate-completion bash > target/zellij.bash'
    system './target/release/zellij setup --generate-completion fish > target/zellij.fish'
    system './target/release/zellij setup --generate-completion zsh > target/zellij.zsh'
  end

  rust_install_extras do
    FileUtils.install 'target/bash.d.zellij', "#{CREW_DEST_PREFIX}/etc/bash.d/zellij", mode: 0o755
    FileUtils.install 'target/zellij.bash', "#{CREW_DEST_PREFIX}/share/bash-completion/completions/zellij", mode: 0o644
    FileUtils.install 'target/zellij.fish', "#{CREW_DEST_PREFIX}/share/fish/vendor_completions.d/zellij.fish", mode: 0o644
    FileUtils.install 'target/zellij.zsh', "#{CREW_DEST_PREFIX}/share/zsh/site-functions/_zellij", mode: 0o644
  end
end
