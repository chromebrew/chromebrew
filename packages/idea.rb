require 'package'

class Idea < Package
  description 'Capable and Ergonomic IDE for JVM'
  homepage 'https://www.jetbrains.com/idea/'
  version '2021.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://download.jetbrains.com/idea/ideaIC-2021.3.tar.gz'
  source_sha256 'de44097f00f4f9c48cf5abc2fab58c6436a4345f00f83ae7a75734af177e3077'

  depends_on 'jdk8'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.IdeaIC2021.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.IdeaIC2021.3"
    system "touch #{CREW_DEST_PREFIX}/.config/.IdeaIC2021.3/test"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.IdeaIC2021.3", "#{CREW_DEST_HOME}/.IdeaIC2021.3"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Idea/bin/idea.sh", "#{CREW_DEST_PREFIX}/bin/idea"
  end

  def self.postinstall
    puts "\nTo get started, type 'idea'.\n".lightblue
  end

  def self.remove
    print "Would you like to remove the config directories? [y/N] "
    response = STDIN.getc
    config_dirs = ["#{CREW_PREFIX}/.config/.IdeaIC2021.3", "#{HOME}/.IdeaIC2021.3"]
    config_dirs.each { |config_dir|
      if Dir.exist? config_dir
        case response
        when 'y', 'Y'
          FileUtils.rm_rf config_dir
          puts "#{config_dir} removed.".lightred
        else
          puts "#{config_dir} saved.".lightgreen
        end
      end
    }
  end
end
