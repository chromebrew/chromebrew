require 'package'

class Tauri_cli < Package
  description 'Build smaller, faster, and more secure desktop and mobile applications with a web frontend.'
  homepage 'https://tauri.app/'
  version '2.12.2'
  license 'Apache-2.0, MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/tauri-apps/tauri/releases/download/tauri-cli-v#{version}/cargo-tauri-x86_64-unknown-linux-gnu.tgz"
  source_sha256 '35c7b50266256cb6d5f757608d7097a59a5faeb0c75879ee1f504652a9b6087e'

  no_compile_needed

  def self.install
    FileUtils.install 'cargo-tauri', "#{CREW_DEST_PREFIX}/bin/tauri", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'tauri' to get started.\n"
  end
end
