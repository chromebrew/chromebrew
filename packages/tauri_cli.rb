require 'package'

class Tauri_cli < Package
  description 'Build smaller, faster, and more secure desktop and mobile applications with a web frontend.'
  homepage 'https://tauri.app/'
  version '2.11.2'
  license 'Apache-2.0, MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/tauri-apps/tauri/releases/download/tauri-cli-v#{version}/cargo-tauri-x86_64-unknown-linux-gnu.tgz"
  source_sha256 '1da3864154731ca0c98436392d4793c70a3f151be7beb59d8aa17092aca53c1e'

  no_compile_needed

  def self.install
    FileUtils.install 'cargo-tauri', "#{CREW_DEST_PREFIX}/bin/tauri", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'tauri' to get started.\n"
  end
end
