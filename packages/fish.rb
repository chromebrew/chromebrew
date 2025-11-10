require 'buildsystems/cmake'

class Fish < CMake
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'https://fishshell.com/'
  version '4.2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4bd54a0e4b962e8683c21042ebb6903417d3dad9d41c3cf3e2a1b2205a6f07a7',
     armv7l: '4bd54a0e4b962e8683c21042ebb6903417d3dad9d41c3cf3e2a1b2205a6f07a7',
       i686: 'ba90bb8e21abf241eaf8205ec58eebe773e32e251a7a0b1886492789b137d344',
     x86_64: 'cac01859bff230beaf70ff7ccb2b3562b229e3eaf3ec9220d453f7601cc2fdb5'
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
