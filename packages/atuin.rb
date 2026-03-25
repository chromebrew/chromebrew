require 'package'

class Atuin < Package
  description 'Sync, search and backup shell history.'
  homepage 'https://atuin.sh/'
  version '18.13.5'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/atuinsh/atuin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2eaf79d1ea0385abbcdbc705e45d154263213d141b3b7a0f6151f4373b9de95d',
     armv7l: '2eaf79d1ea0385abbcdbc705e45d154263213d141b3b7a0f6151f4373b9de95d',
     x86_64: '4fbfa361c68850b90d5f915e338ce5e0fd7a69e79d0ba7660291e842a37540fe'
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
