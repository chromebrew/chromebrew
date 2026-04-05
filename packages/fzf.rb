require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.71.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'all'
  source_url 'https://github.com/junegunn/fzf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d535e887908ca2df74cae9a2d8d761f7f840bd17e7b7c9525cd8e364f21111c',
     armv7l: '7d535e887908ca2df74cae9a2d8d761f7f840bd17e7b7c9525cd8e364f21111c',
       i686: 'e0bd8a9f63f1df3b71e0d6be588df73409dd2da9254bb3331451a0b6418d814c',
     x86_64: 'e8222e3c75d96cd46b26954d4b6251731137d61b16a3b3b8f3628e903f87dee7'
  })

  depends_on 'glibc' => :executable
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
