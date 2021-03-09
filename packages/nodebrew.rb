require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  @_ver = '1.0.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/hokaccha/nodebrew/archive/v#{@_ver}.tar.gz"
  source_sha256 'c34e7186d4fd493c5417ad5563ad39fd493a42695bd9a7758c3df10380e43399'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-1.0.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-1.0.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-1.0.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-1.0.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e3c4bfac2033982be9859766dc9b7c00a018cbdc0c233f54b0725295baabd770',
     armv7l: 'e3c4bfac2033982be9859766dc9b7c00a018cbdc0c233f54b0725295baabd770',
       i686: 'ca1437cc074946cd723a691a89ca127d3c1f95beea6015fa74cf66fe074a6c22',
     x86_64: 'bcf965ab509fca115094ba9ed146c0b9fe43a37055b2b233b32cf77bde659f08'
  })

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
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/share/nodebrew/default", "#{CREW_PREFIX}/share/nodebrew/current"
    puts
    puts 'Nodebrew completion support is available for the following shells:'.lightblue
    puts 'bash fish zsh'.lightblue
    puts
    puts 'To add nodebrew completion for bash, execute the following:'.lightblue
    puts "echo '# nodebrew completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/nodebrew/completions/bash/nodebrew-completion ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/nodebrew/completions/bash/nodebrew-completion' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
    puts 'To complete the installation, execute the following:'.lightblue
    puts "echo 'export PATH=\$HOME/.nodebrew/current/bin:\$PATH' >> ~/.bashrc && source ~/.bashrc".lightblue
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
