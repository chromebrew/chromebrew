require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.57.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'c9d4c206e9d0dafb69e02d9ffcc8ee19cf9df02b34d12177a229d0bdc0e43081',
     armv7l: 'c9d4c206e9d0dafb69e02d9ffcc8ee19cf9df02b34d12177a229d0bdc0e43081',
     x86_64: 'a3c087a5f40e8bb4d9bfb26faffa094643df111a469646bef53154a54af9ff92'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
