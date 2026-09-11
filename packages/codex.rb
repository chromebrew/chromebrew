require 'package'

class Codex < Package
  description 'Lightweight coding agent that runs in your terminal'
  homepage 'https://github.com/openai/codex'
  version '0.154.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/openai/codex/releases/download/rust-v#{version}/codex-x86_64-unknown-linux-musl.zst"
  source_sha256 'beae6a48305df6fd21c8b39489a900f7a9a35617933ee6b0975bcfdb5b542925'

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
