require 'package'

class Codex < Package
  description 'Lightweight coding agent that runs in your terminal'
  homepage 'https://github.com/openai/codex'
  version '0.116.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/openai/codex/releases/download/rust-v#{version}/codex-x86_64-unknown-linux-gnu.zst"
  source_sha256 '0c8719350dee91f182779e84ebb4c5a8dd289ced452da89a8f8196d4e9a9de92'

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
