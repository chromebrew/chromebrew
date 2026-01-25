require 'buildsystems/rust'

class Hurl < RUST
  description 'Hurl is a command line tool that runs HTTP requests defined in a simple plain text format.'
  homepage 'https://hurl.dev/'
  version '7.1.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/Orange-OpenSource/hurl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '5ff7edcca23cd4acc96681e2f6943b9e82326a5905cdac6ff40a9c1b6a3c17cb'
  })

  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'llvm_dev' => :build
  depends_on 'openssl' => :build
  depends_on 'rust' => :build

  rust_install_path 'packages/hurl packages/hurlfmt'

  rust_install_extras do
    Dir.chdir 'docs/manual' do
      FileUtils.install %w[hurl.1 hurlfmt.1], "#{CREW_DEST_MAN_PREFIX}/man1", mode: 0o644
    end
  end
end
