require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  version 'v0.9.7-1'
  source_url 'https://github.com/hokaccha/nodebrew/archive/v0.9.7.tar.gz'
  source_sha256 '3aa8b0cf30024d105f1ac6921aadf0440bc95bcae43df9d6ec58fc9de8cd352e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-v0.9.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-v0.9.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-v0.9.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nodebrew-v0.9.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bd9aa8fcac6099e5367d687a90578cab3ec2281f50301c57268540b82d40b203',
     armv7l: 'bd9aa8fcac6099e5367d687a90578cab3ec2281f50301c57268540b82d40b203',
       i686: '8b4bf0c1169bf44b1d45a13d3adaff3c2a9573c43acd262bd3255ef07e276351',
     x86_64: '8ec7697374c124d37cc905ba0d6e7c07fad4cbee789ada940d9528c114a691de',
  })

  depends_on 'perl'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/nodebrew"
    system "NODEBREW_ROOT=#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/nodebrew perl nodebrew setup > /dev/null"

    system "mkdir -p #{CREW_DEST_DIR}/$HOME"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/nodebrew #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/current/bin/node #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/current/bin/npm #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/current/bin/npx #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew #{CREW_DEST_DIR}/$HOME/.nodebrew"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew $HOME/.nodebrew"
    puts
    puts "Nodebrew completion support is available for the following shells:"
    puts "bash fish zsh"
    puts
    puts "To add nodebrew completion for bash, execute the following:".lightblue
    puts "echo '# nodebrew completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_LIB_PREFIX}/nodebrew/completions/bash/nodebrew-completion ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_LIB_PREFIX}/nodebrew/completions/bash/nodebrew-completion' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$HOME/.nodebrew/current/bin:\$PATH' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
    puts "To install the latest node, please execute:".lightblue
    puts "\tnodebrew install-binary latest".lightblue
    puts "\tnodebrew use latest".lightblue
    puts
  end
end
