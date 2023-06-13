require 'package'

class Idea < Package
  description 'Capable and Ergonomic IDE for JVM'
  homepage 'https://www.jetbrains.com/idea/'
  version '2022.3'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://download.jetbrains.com/idea/ideaIC-2022.3.tar.gz'
  source_sha256 'a3f53de8293b55739d916868d732bde521e33e59a5181e758d6f1691d479da9e'

  depends_on 'openjdk8'
  depends_on 'gdk_base'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  no_compile_needed
  no_fhs

  def self.install
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.IdeaIC2022.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.IdeaIC2022.3"
    FileUtils.touch "#{CREW_DEST_PREFIX}/.config/.IdeaIC2022.3/test"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.IdeaIC2022.3", "#{CREW_DEST_HOME}/.IdeaIC2022.3"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Idea/bin/idea.sh", "#{CREW_DEST_PREFIX}/bin/idea"
  end

  def self.postinstall
    puts "\nTo finish the install, execute the following:".lightblue
    puts "source #{CREW_PREFIX}/etc/env.d/09-gdk_base".lightblue
    puts "\nTo get started, type 'idea'.\n".lightblue
  end

  def self.remove
    print 'Would you like to remove the config directories? [y/N] '
    response = $stdin.gets.chomp.downcase
    config_dirs = ["#{CREW_PREFIX}/.config/JetBrains/.IdeaIC2022.3", "#{HOME}/.IdeaIC2022.3"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      case response
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
