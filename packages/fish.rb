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
    aarch64: '5e5fe3027a6d9d27deba270d354d11d2408bf4260ef244e271a184e91508c177',
     armv7l: '5e5fe3027a6d9d27deba270d354d11d2408bf4260ef244e271a184e91508c177',
       i686: 'd5d2288469058e2a6312aba366e465a827e28953eaecfaed8578658c93bebacc',
     x86_64: '0e8eea821e0de6680fad136957517baa29dbb1be9e5b81495489fe29e6c009c7'
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
