require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  @_ver = '1.0.1'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/hokaccha/nodebrew/archive/v#{@_ver}.tar.gz"
  source_sha256 'c34e7186d4fd493c5417ad5563ad39fd493a42695bd9a7758c3df10380e43399'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/nodebrew/default"
    system "NODEBREW_ROOT=#{CREW_DEST_PREFIX}/share/nodebrew perl nodebrew setup > /dev/null"
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/nodebrew", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/node", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/npm", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/npx", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/node", "#{CREW_DEST_PREFIX}/bin/nodejs"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew", "#{CREW_DEST_HOME}/.nodebrew"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/nodebrew", "#{HOME}/.nodebrew"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @bashd = <<~EOF
      # nodebrew bash completion
      source #{CREW_PREFIX}/share/nodebrew/completions/bash/nodebrew-completion
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/nodebrew", @bashd)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~EOF
      # nodebrew configuration
      export PATH="$PATH:$HOME/.nodebrew/current/bin"
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/nodebrew", @env)
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/share/nodebrew/default", "#{CREW_PREFIX}/share/nodebrew/current"
    puts
    puts 'To install the latest node, execute:'.lightblue
    puts 'nodebrew install-binary latest'.lightblue
    puts 'nodebrew use latest'.lightblue
    puts
  end

  def self.remove
    if Dir.exists? "#{CREW_PREFIX}/share/nodebrew"
      puts
      print "Would you like to remove #{CREW_PREFIX}/share/nodebrew? [y/N] "
      response = STDIN.getc
      case response
      when "y", "Y"
        FileUtils.rm_rf "#{CREW_PREFIX}/share/nodebrew"
        puts "#{CREW_PREFIX}/share/nodebrew removed.".lightred
      else
        puts "#{CREW_PREFIX}/share/nodebrew saved.".lightgreen
      end
      puts
    end
  end
end
