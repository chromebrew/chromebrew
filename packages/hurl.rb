require 'buildsystems/rust'

class Hurl < RUST
  description 'Hurl is a command line tool that runs HTTP requests defined in a simple plain text format.'
  homepage 'https://hurl.dev/'
  version '7.0.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/Orange-OpenSource/hurl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'bae3d7291c2046ee47a49ba34061188fbba9b397e9f6f731bcb973ed8c30d5c2'
  })

  depends_on 'curl' # R
  depends_on 'curl' => :build
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
