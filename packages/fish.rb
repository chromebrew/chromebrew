require 'buildsystems/cmake'

class Fish < CMake
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'https://fishshell.com/'
  version '4.7.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '344c1bae8b6b28915fd860d89ef508c216b71bc1bf08f32e23bfe2a53901b7cc',
     armv7l: '344c1bae8b6b28915fd860d89ef508c216b71bc1bf08f32e23bfe2a53901b7cc',
       i686: 'ec8e8cf814f4bbe9518ce724989093805538171e8270b42b77c3b678a68ecea1',
     x86_64: 'a65cc40effdb0918d9ea0642e26160cff2c1a564de221ada405de5ee99be188c'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'pcre2' => :executable

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
