require 'package'

class Pycharm < Package
  description 'The Python IDE for Professional Developers'
  homepage 'https://www.jetbrains.com/pycharm/'
  version '2019.3.2'
  source_url 'https://download.jetbrains.com/python/pycharm-community-2019.3.2.tar.gz'
  source_sha256 '2262e37adbf00a65c9d672c2fa338aa97e4a17a853ffa915da0f4b83b5c4bf19'

  depends_on 'jdk8'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    # Fix java.io.IOException: Cannot run program "/home/chronos/user/.PyCharmCE2019.3/system/tmp/ij1055598732.tmp": error=13, Permission denied
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/.config/.PyCharmCE2019.3"
    system "touch #{CREW_DEST_PREFIX}/.config/.PyCharmCE2019.3/test"
    FileUtils.ln_s "#{CREW_PREFIX}/.config/.PyCharmCE2019.3", "#{CREW_DEST_HOME}/.PyCharmCE2019.3"
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
