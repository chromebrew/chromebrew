require 'package'

class Codex < Package
  description 'Lightweight coding agent that runs in your terminal'
  homepage 'https://github.com/openai/codex'
  version '0.87.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/openai/codex/releases/download/rust-v#{version}/codex-x86_64-unknown-linux-gnu.zst"
  source_sha256 '0e4fbd4f21e88a7dbce96f0acc88dd91c53b76f625dc7d436398ae732743c4fc'

  depends_on 'zstd'

  no_compile_needed

  def self.install
    system 'zstd -dv codex-x86_64-unknown-linux-gnu.zst'
    FileUtils.install 'codex-x86_64-unknown-linux-gnu', "#{CREW_DEST_PREFIX}/bin/codex", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'codex' to get started.\n"
  end
end
