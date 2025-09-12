require 'buildsystems/cmake'

class Fish < CMake
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'https://fishshell.com/'
  version '4.0.6'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a8dc363a9cbb6383515427db5ec18277a484a1340f24c537331e77dabcabf72',
     armv7l: '9a8dc363a9cbb6383515427db5ec18277a484a1340f24c537331e77dabcabf72',
       i686: '4f68ad640ce49b656ee4188ffca86734a390ed024c5b44eb6a6d4facbc0ebe52',
     x86_64: 'cda6c7966079790368cb65d6842b3f62f8c1e0621ec62b47d1585eff7c880735'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre2' # R

  cmake_options "-DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncurses"

  def self.postinstall
    ExitMessage.add <<~EOT1.lightblue
      To run fish, type `fish` in your terminal.
      Even if you are already in fish, you should now start a new fish session.

      To use fish as your login shell:
      * add the line '#{CREW_PREFIX}/bin/fish' to the file '#{CREW_PREFIX}/etc/shells':
      echo '#{CREW_PREFIX}/bin/fish' | tee -a #{CREW_PREFIX}/etc/shells > /dev/null
      * run 'chsh -s #{CREW_PREFIX}/bin/fish'

      To set your colors, run `fish_config`
      To scan your man pages for completions, run `fish_update_completions`
      To accept autosuggestions (in grey) as you type, hit `ctrl-F` or right arrow key.

      Have fun! <><
    EOT1
  end
end
