require 'package'

class Atuin < Package
  description 'Sync, search and backup shell history.'
  homepage 'https://atuin.sh/'
  version '18.22.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/atuinsh/atuin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17e46a1910c3653a2e9815e8ee91be91cde5c2ffa07ec0e24bfba8fb3d6d1f0b',
     armv7l: '17e46a1910c3653a2e9815e8ee91be91cde5c2ffa07ec0e24bfba8fb3d6d1f0b',
     x86_64: '9183cbf8fc7af58f733b2d8f90b07ea111f98b9908b3446cadca0fa1a7b94ffd'
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
