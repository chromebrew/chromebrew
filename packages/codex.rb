require 'package'

class Codex < Package
  description 'Lightweight coding agent that runs in your terminal'
  homepage 'https://github.com/openai/codex'
  version '0.165.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/openai/codex/releases/download/rust-v#{version}/codex-x86_64-unknown-linux-musl.zst"
  source_sha256 '6a1dd543fb806e2e38046dde60278aeb1d20704b7b05b27b2723029ba341b7e4'

  depends_on 'zstd'

  no_compile_needed

  def self.install
    system 'zstd -dv codex-x86_64-unknown-linux-musl.zst'
    FileUtils.install 'codex-x86_64-unknown-linux-musl', "#{CREW_DEST_PREFIX}/bin/codex", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'codex' to get started.\n"
  end
end
