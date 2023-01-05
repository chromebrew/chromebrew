require 'package'

class Leiningen < Package
  description 'for automating Clojure projects without setting your hair on fire'
  homepage 'https://leiningen.org/'
  version '2.9.8'
  license 'EPL-1.0'
  compatibility 'all'
  source_url 'https://github.com/technomancy/leiningen/archive/2.9.8.tar.gz'
  source_sha256 'be299cbd70693213c6887f931327fb9df3bd54930a521d0fc88bea04d55c5cd4'

  depends_on 'clojure'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'bin/lein', "#{CREW_DEST_PREFIX}/bin/lein", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'lein' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.lein"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
