require 'package'

class Pycharm < Package
  description 'The Python IDE for Professional Developers'
  homepage 'https://www.jetbrains.com/pycharm/'
  version '2021.3.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://download.jetbrains.com/python/pycharm-community-2021.3.2.tar.gz'
  source_sha256 'f1ae01f471d01c6f09aab0a761c6dea9834ef584f2aaf6d6ebecdce6b55a66e8'

  depends_on 'jdk8'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.patch
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.PyCharmCE2019.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.PyCharmCE2021.3"
    system "touch #{CREW_DEST_PREFIX}/.config/.PyCharmCE2021.3/test"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.PyCharmCE2021.3", "#{CREW_DEST_HOME}/.PyCharmCE2021.3"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/PyCharm"
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/PyCharm"
    FileUtils.ln_s "#{CREW_PREFIX}/share/PyCharm/bin/pycharm.sh", "#{CREW_DEST_PREFIX}/bin/pycharm"
  end

  def self.postinstall
    puts "\nType 'pycharm' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/.config/.PyCharmCE2021.3"
    if Dir.exist? config_dir
      puts "WARNING: This will remove all PyCharm config!".orange
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case STDIN.getc
      when "y", "Y"
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
