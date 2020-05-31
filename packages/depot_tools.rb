require 'package'

class Depot_tools < Package
  description 'Chromium uses a package of scripts, the depot_tools, to manage interaction with the Chromium source code repository and the Chromium development process.'
  homepage 'http://dev.chromium.org/developers/how-tos/depottools'
  version '906bfde9'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xdg_base'

  def self.install
    system 'git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git'
    Dir.chdir 'depot_tools' do
      system "git checkout #{version}"
      FileUtils.rm_rf 'man/src'
      FileUtils.rm_rf Dir.glob('.git*')
      system 'find -name \'*.bat\' -exec rm {} +'
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/depot_tools"
      FileUtils.mv 'man/', "#{CREW_DEST_PREFIX}/share"
      FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/depot_tools"
      FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/.vpython-root"
      FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/.vpython_cipd_cache"
      FileUtils.ln_s "#{HOME}/.config/.vpython-root/", "#{CREW_DEST_HOME}/.vpython-root"
      FileUtils.ln_s "#{HOME}/.config/.vpython_cipd_cache/", "#{CREW_DEST_HOME}/.vpython_cipd_cache"
    end
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "echo 'export PATH=\$PATH:#{CREW_PREFIX}/share/depot_tools' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts
    puts "To get started, type 'man depot_tools_tutorial'.".lightblue
    puts
    puts "To completely remove, execute the following:".lightblue
    puts "crew remove depot_tools".lightblue
    puts "sudo rm -rf ~/.config/.vpython*".lightblue
    puts
  end
end
