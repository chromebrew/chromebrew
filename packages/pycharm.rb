require 'package'

class Pycharm < Package
  description 'The Python IDE for Professional Developers'
  homepage 'https://www.jetbrains.com/pycharm/'
  version '2025.2.6.1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url "https://download.jetbrains.com/python/pycharm-community-#{version}.tar.gz"
  source_sha256 'bb77e06e2153285827a2bf1593ef3a632f92fb7ce577c379c22a8ddb03ddbe2b'

  depends_on 'openjdk17'
  depends_on 'xdg_base'
  depends_on 'sommelier' => :logical

  def self.preflight
    MiscFunctions.check_free_disk_space(2147483648)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/PyCharm"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/PyCharm"
    FileUtils.ln_s "#{CREW_PREFIX}/share/PyCharm/bin/pycharm", "#{CREW_DEST_PREFIX}/bin/pycharm"
  end

  def self.postinstall
    ExitMessage.add "\nType 'pycharm' to get started.\n"
  end

  def self.postremove
    config_dir = "#{CREW_PREFIX}/.config/JetBrains/PyCharmCE#{version.split('.')[0..1].join('.')}"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all PyCharm config!'.orange
      Package.agree_to_remove(config_dir)
    end
  end
end
