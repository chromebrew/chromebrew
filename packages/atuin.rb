require 'package'

class Atuin < Package
  description 'Sync, search and backup shell history.'
  homepage 'https://atuin.sh/'
  version '18.18.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/atuinsh/atuin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f8c4eb1ff120e1c8d61100895f1bcd8517c36080f9932c013dcc31bf2f67513',
     armv7l: '9f8c4eb1ff120e1c8d61100895f1bcd8517c36080f9932c013dcc31bf2f67513',
     x86_64: 'dbb88b8e2def41713c26d916b6486ff0d8682f00c3306df50fd0bf50eede5f2f'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
