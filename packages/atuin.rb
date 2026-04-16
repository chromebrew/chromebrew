require 'package'

class Atuin < Package
  description 'Sync, search and backup shell history.'
  homepage 'https://atuin.sh/'
  version '18.15.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/atuinsh/atuin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '39e80eab2e91cf3dc0da4c0ba7939aaa80572383b5f4ca8e2f6bff83d3c3cbf2',
     armv7l: '39e80eab2e91cf3dc0da4c0ba7939aaa80572383b5f4ca8e2f6bff83d3c3cbf2',
     x86_64: 'd4fc2192f7dc6aacd9b20279b952ce2718d1af86274ad0f38ac3959dc33c0a9f'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
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
