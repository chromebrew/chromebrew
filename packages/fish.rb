require 'package'

class Fish < Package
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '2.7.1-1'
  source_url 'https://github.com/fish-shell/fish-shell/releases/download/2.7.1/fish-2.7.1.tar.gz'
  source_sha256 'e42bb19c7586356905a58578190be792df960fa81de35effb1ca5a5a981f0c5a'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncurses'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To run fish, type `fish` in your terminal.".lightblue
    puts "Even if you are already in fish, you should now start a new fish session.".lightblue
    puts
    puts "To use fish as your login shell:".lightblue
    puts "* add the line '#{CREW_PREFIX}/bin/fish' to the file '#{CREW_PREFIX}/etc/shells':".lightblue
    puts "echo '#{CREW_PREFIX}/bin/fish' | tee -a #{CREW_PREFIX}/etc/shells > /dev/null".lightblue
    puts "* run 'chsh -s #{CREW_PREFIX}/bin/fish'".lightblue
    puts
    puts "If you have SELinux enabled, you may need to manually update the security policy:".lightblue
    puts "* use the command 'chcon -t shell_exec_t #{CREW_PREFIX}/bin/fish'".lightblue
    puts
    puts "To set your colors, run `fish_config`".lightblue
    puts "To scan your man pages for completions, run `fish_update_completions`".lightblue
    puts "To accept autosuggestions (in grey) as you type, hit `ctrl-F` or right arrow key.".lightblue
    puts
    puts "Have fun! <><".lightblue
    puts
  end
end
