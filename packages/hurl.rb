require 'buildsystems/rust'

class Hurl < RUST
  description 'Hurl is a command line tool that runs HTTP requests defined in a simple plain text format.'
  homepage 'https://hurl.dev/'
  version '8.1.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/Orange-OpenSource/hurl.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '225a9e5590b83d02dc69deb145a9102cce607ca4ae8c35974d238a29af97cdb6'
  })

  depends_on 'curl' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
