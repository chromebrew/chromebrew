require 'package'

class Idea < Package
  description 'Capable and Ergonomic IDE for JVM'
  homepage 'https://www.jetbrains.com/idea/'
  version '2024.1.4'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://download.jetbrains.com/idea/ideaIU-#{version}.tar.gz"
  source_sha256 'cda20bbbc052c2b8e87ea8607235ee0f7b5775728e8648c0a603889a3efa685f'

  depends_on 'openjdk8'
  depends_on 'gdk_base'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  no_compile_needed
  no_fhs
  print_source_bashrc

  def self.install
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.IdeaIC2022.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.IdeaIC2022.3"
    FileUtils.touch "#{CREW_DEST_PREFIX}/.config/.IdeaIC2022.3/test"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.IdeaIC2022.3", "#{CREW_DEST_HOME}/.IdeaIC2022.3"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/Idea"
    FileUtils.ln_s "#{CREW_PREFIX}/share/Idea/bin/idea.sh", "#{CREW_DEST_PREFIX}/bin/idea"
  end

  def self.postinstall
    ExitMessage.add "Type 'idea' to get started."
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
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
