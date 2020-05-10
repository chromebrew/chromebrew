require 'package'

class Pycharm < Package
  description 'The Python IDE for Professional Developers'
  homepage 'https://www.jetbrains.com/pycharm/'
  version '2019.3.3'
  compatibility 'all'
  source_url 'https://download.jetbrains.com/python/pycharm-community-anaconda-2019.3.3.tar.gz'
  source_sha256 'e84d392bfaeaf8b382ce7948261be2ff6d8bade5351b392571eb4c243aa88a61'

  depends_on 'jdk8'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.patch
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.PyCharmCE2019.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.PyCharmCE2019.3"
    system "touch #{CREW_DEST_PREFIX}/.config/.PyCharmCE2019.3/test"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.PyCharmCE2019.3", "#{CREW_DEST_HOME}/.PyCharmCE2019.3"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/PyCharm"
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/PyCharm"
    FileUtils.ln_s "#{CREW_PREFIX}/share/PyCharm/bin/pycharm.sh", "#{CREW_DEST_PREFIX}/bin/pycharm"
  end

  def self.postinstall
    puts
    puts "To get started, type 'pycharm'.".lightblue
    puts
    puts "To completely remove including all preferences, execute the following:".lightblue
    puts "crew remove pycharm".lightblue
    puts "rm -rf #{CREW_PREFIX}/.config/.PyCharmCE2019.3".lightblue
    puts
  end
end
