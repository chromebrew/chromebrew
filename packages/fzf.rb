require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.73.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'all'
  source_url 'https://github.com/junegunn/fzf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33c6853d49eba09ffd3b2f9b9cd98c4275a652ae2a191cc32de080f7cfde03b7',
     armv7l: '33c6853d49eba09ffd3b2f9b9cd98c4275a652ae2a191cc32de080f7cfde03b7',
       i686: '14c6f16530de5a65ad1a683a90e49eaffb36aa268321ce8ebccc8c615b15452b',
     x86_64: '6f39c6401a8e2bbaba2d41ac92889596ce75e6fb6aa104db60471bb8f96fa2d9'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build
  depends_on 'tmux' # R - Needed for tmux integration

  print_source_bashrc

  def self.build
    File.write '10-fzf', <<~EOF
      # Set up fzf key bindings and fuzzy completion
      eval "$(fzf --bash)"
    EOF
    system 'go build -o bin/fzf'
  end

  def self.install
    FileUtils.install 'bin/fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
    FileUtils.install 'bin/fzf-tmux', "#{CREW_DEST_PREFIX}/bin/fzf-tmux", mode: 0o755
    FileUtils.install 'man/man1/fzf.1', "#{CREW_DEST_MAN_PREFIX}/man1/fzf.1", mode: 0o644
    FileUtils.install 'man/man1/fzf-tmux.1', "#{CREW_DEST_MAN_PREFIX}/man1/fzf-tmux.1", mode: 0o644
    FileUtils.install '10-fzf', "#{CREW_DEST_PREFIX}/etc/bash.d/10-fzf", mode: 0o644
  end
end
