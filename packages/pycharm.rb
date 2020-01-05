require 'package'

class Pycharm < Package
  description 'The Python IDE for Professional Developers'
  homepage 'https://www.jetbrains.com/pycharm/'
  version '2019.3.1'
  source_url 'https://download.jetbrains.com/python/pycharm-community-anaconda-2019.3.1.tar.gz'
  source_sha256 '05562eb56ecf8cfd798e6561db9567a4cafefa8b8e5411d7043e9a65fef60eb9'

  binary_url ({
  })
  binary_sha256 ({
  })

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
