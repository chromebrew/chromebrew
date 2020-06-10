require 'package'

class Fish < Package
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '2.7.1-1'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell/releases/download/2.7.1/fish-2.7.1.tar.gz'
  source_sha256 'e42bb19c7586356905a58578190be792df960fa81de35effb1ca5a5a981f0c5a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fish-2.7.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fish-2.7.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fish-2.7.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fish-2.7.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b9cc7f130de93e55605660f7fd8b98283ef1877ed8968d5889d0ecaa041b476e',
     armv7l: 'b9cc7f130de93e55605660f7fd8b98283ef1877ed8968d5889d0ecaa041b476e',
       i686: '0cfe2d362b929264ec3a487d51cba511313c8f20a81067b37c76f84ae864a1a7',
     x86_64: '56dd0139ed8a13d178151863cf79521a676e7e3778cd75790dac5f6e48e7bfa0',
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
