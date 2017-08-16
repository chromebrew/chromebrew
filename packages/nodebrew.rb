require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  version 'v0.9.7'
  source_url 'https://github.com/hokaccha/nodebrew/archive/v0.9.7.tar.gz'
  source_sha256 '3aa8b0cf30024d105f1ac6921aadf0440bc95bcae43df9d6ec58fc9de8cd352e'

  depends_on 'perl'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/nodebrew"
    system "NODEBREW_ROOT=#{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/nodebrew perl nodebrew setup > /dev/null"

    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/bin"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/nodebrew #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/current/bin/node #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/current/bin/npm #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"
    system "ln -s #{CREW_LIB_PREFIX}/nodebrew/current/bin/npx #{CREW_DEST_DIR}#{CREW_PREFIX}/bin/"

    system "ln -s #{CREW_LIB_PREFIX}/nodebrew $HOME/.nodebrew"

    puts ""
    puts "Please set PATH environment variable."
    puts "\texport PATH=$HOME/.nodebrew/current/bin:$PATH"
    puts ""
    puts "To install the latest node, please execute:"
    puts "\tnodebrew install-binary latest"
    puts "\tnodebrew use latest"
    puts ""
  end
end
