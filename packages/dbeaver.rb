require 'package'

class Dbeaver < Package
  description 'Free Universal Database Tool'
  homepage 'https://dbeaver.io'
  version '24.1.5'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url({
    x86_64: "https://github.com/dbeaver/dbeaver/releases/download/#{version}/dbeaver-ce-#{version}-linux.gtk.x86_64.tar.gz"
  })
  source_sha256({
    x86_64: '59f3b876ef95b0be87d9b4c646349c9ad172197c52971dec693a3f4d3daa955e'
  })

  depends_on 'gtk3'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  no_compile_needed

  def self.patch
    system "sed -i 's,/usr/share/dbeaver-ce,#{CREW_PREFIX}/share/dbeaver,g' dbeaver-ce.desktop"
    system "sed -i 's,#{CREW_PREFIX}/share/dbeaver/dbeaver.png,dbeaver.png,' dbeaver-ce.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dbeaver"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons/hicolor/256x256/apps"
    FileUtils.mv 'dbeaver-ce.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'dbeaver.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/256x256/apps"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/dbeaver"
    FileUtils.ln_s "#{CREW_PREFIX}/share/dbeaver/dbeaver", "#{CREW_DEST_PREFIX}/bin/dbeaver"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dbeaver' to get started.\n"
  end

  def self.postremove
    config_dir = "#{HOME}/.local/share/DBeaverData"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
