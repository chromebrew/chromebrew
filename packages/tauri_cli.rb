require 'package'

class Tauri_cli < Package
  description 'Build smaller, faster, and more secure desktop and mobile applications with a web frontend.'
  homepage 'https://tauri.app/'
  version '2.11.4'
  license 'Apache-2.0, MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/tauri-apps/tauri/releases/download/tauri-cli-v#{version}/cargo-tauri-x86_64-unknown-linux-gnu.tgz"
  source_sha256 '6864602a34292aa6f2ad40ae019eebe5c1064d6c623fe20696a8a8974067e60b'

  no_compile_needed

  def self.install
    FileUtils.install 'cargo-tauri', "#{CREW_DEST_PREFIX}/bin/tauri", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'tauri' to get started.\n"
  end
end
