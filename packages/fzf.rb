require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.43.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/junegunn/fzf/releases/download/0.43.0/fzf-0.43.0-linux_armv7.tar.gz',
     armv7l: 'https://github.com/junegunn/fzf/releases/download/0.43.0/fzf-0.43.0-linux_armv7.tar.gz',
     x86_64: 'https://github.com/junegunn/fzf/releases/download/0.43.0/fzf-0.43.0-linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '19f366b9f9032b4185f3906be183efa9c0411a3409a1db1c17f4fcc01cf8ec2e',
     armv7l: '19f366b9f9032b4185f3906be183efa9c0411a3409a1db1c17f4fcc01cf8ec2e',
     x86_64: 'a43b0b22649c8e7b2ff7528a5169f868273ba1f74bd5bb4beb282c4af619eb65'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
