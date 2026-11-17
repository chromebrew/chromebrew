require 'package'

class Tauri_cli < Package
  description 'Build smaller, faster, and more secure desktop and mobile applications with a web frontend.'
  homepage 'https://tauri.app/'
  version '2.12.5'
  license 'Apache-2.0, MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/tauri-apps/tauri/releases/download/tauri-cli-v#{version}/cargo-tauri-x86_64-unknown-linux-gnu.tgz"
  source_sha256 '79f9596308f74e41753d1d30688a3f41914187b1bc7eea5dbd20cc0cd6acd640'

  no_compile_needed

  def self.install
    FileUtils.install 'cargo-tauri', "#{CREW_DEST_PREFIX}/bin/tauri", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'tauri' to get started.\n"
  end
end
