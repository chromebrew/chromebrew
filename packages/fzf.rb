require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.74.4'
  license 'MIT and BSD-with-disclosure'
  compatibility 'all'
  source_url 'https://github.com/junegunn/fzf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5b0abfbc5f17ef7f13e041b02d2a0ffcf11a0d28e6a0f4d586820b93a3c8d6b',
     armv7l: 'd5b0abfbc5f17ef7f13e041b02d2a0ffcf11a0d28e6a0f4d586820b93a3c8d6b',
       i686: '6eff0e5fbea39de6a5c937c7036c794653c897b20894f872c65ee7fcefce5abb',
     x86_64: '59a16079414e106b398ce2ee4edac4f868db423bb9dc4a4d8565abe1c44e1b0c'
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
