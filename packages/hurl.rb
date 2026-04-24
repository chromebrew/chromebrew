require 'buildsystems/rust'

class Hurl < RUST
  description 'Hurl is a command line tool that runs HTTP requests defined in a simple plain text format.'
  homepage 'https://hurl.dev/'
  version '8.0.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/Orange-OpenSource/hurl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'fa0c14db94d789b48e8967dc9db459457c73d0b3863986951a32cc6030bf3d65'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'libxml2' => :executable
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
