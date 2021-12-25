require 'package'

class Electric < Package
  description 'Electric is a computer-aided design system for electrical circuits.'
  homepage 'https://www.staticfreesoft.com/'
  version '9.07'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.build
    electric = <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/electric/electric.jar "$@"
    EOF
    File.write('electric.sh', electric)
  end

  def self.install
    system "curl -L#o electric.jar https://ftpmirror.gnu.org/electric/electricBinary-9.07.jar"
    abort 'Checksum mismatch. 😔 Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('electric.jar') ) == '3e383f673183265700e0c13a5f7b1d3348247465c3d8817c845d62e4c92d86ce'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/electric"
    FileUtils.mv 'electric.jar', "#{CREW_DEST_PREFIX}/share/electric"
    FileUtils.install 'electric.sh', "#{CREW_DEST_PREFIX}/bin/electric", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'electric' to get started.\n".lightblue
  end

  def self.remove
    log_file = "#{HOME}/electric.log"
    if File.exists? log_file
      print "Would you like to remove #{log_file}? [y/N] "
      case STDIN.getc
      when "y", "Y"
        FileUtils.rm_f log_file
        puts "#{log_file} removed.".lightred
      else
        puts "#{log_file} saved.".lightgreen
      end
    end
  end
end
