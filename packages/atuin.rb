require 'package'

class Atuin < Package
  description 'Sync, search and backup shell history.'
  homepage 'https://atuin.sh/'
  version '18.25.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/atuinsh/atuin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff5694cc98596d017a79cbc97ddf673fcefd372512b673930185ace4352c86e4',
     armv7l: 'ff5694cc98596d017a79cbc97ddf673fcefd372512b673930185ace4352c86e4',
     x86_64: '3299e2093c55235e56e044eb5bbb7ab633eaf6964c9d65b0d58cb832636bb917'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'rust' => :build

  print_source_bashrc

  def self.build
    File.write 'atuin.bash', <<~EOF
      eval "$(atuin init bash)"
    EOF
  end

  def self.install
    Dir.chdir 'crates/atuin' do
      system "cargo install --path . --root #{CREW_DEST_PREFIX}"
    end
    Dir.chdir CREW_DEST_PREFIX do
      FileUtils.rm %w[.crates.toml .crates2.json]
    end
    FileUtils.install 'atuin.bash', "#{CREW_DEST_PREFIX}/etc/env.d/10-atuin", mode: 0o644
  end
end
