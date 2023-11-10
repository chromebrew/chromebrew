require 'package'

class Dexed < Package
  description 'Dexed, the D Extended EDitor, is an IDE for the D programming language, its compilers, tools and libraries.'
  homepage 'https://gitlab.com/basile.b/dexed'
  version '3.9.23'
  license 'Boost Software License - Version 1.0'
  compatibility 'x86_64'
  source_url 'https://gitlab.com/basile.b/dexed/-/releases/v3.9.23/downloads/binaries/dexed.3.9.23.linux64.zip'
  source_sha256 '4710e21879b6b991af883306ffca64dfac2f16332f9903bb6aa006a13caeffea'

  depends_on 'dmd'
  depends_on 'dub'
  depends_on 'gtk2'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  no_compile_needed

  def self.build
    desktop = <<~EOF
      [Desktop Entry]
      Categories=Application;IDE;Development;
      Exec=dexed %f
      GenericName=dexed
      Icon=#{CREW_PREFIX}/share/pixmaps/dexed.png
      Keywords=editor;Dlang;IDE;dmd;
      Name=dexed
      StartupNotify=true
      Terminal=false
      Type=Application
    EOF
    File.write('dexed.desktop', desktop)
    paths = <<~EOF
      object TCompilersPaths
        definedAsGlobal = dmd
        pathsForCompletion = dmd
        DmdExeName = '#{CREW_PREFIX}/bin/dmd'
      end
    EOF
    File.write('compilerspaths.txt', paths)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/dexed"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/pixmaps"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install %w[dcd-client dcd-server dexed dscanner], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'libdexed-d.so', CREW_DEST_LIB_PREFIX, mode: 0o644
    FileUtils.install 'dexed.png', "#{CREW_DEST_PREFIX}/share/pixmaps", mode: 0o644
    FileUtils.install 'compilerspaths.txt', "#{CREW_DEST_HOME}/.config/dexed", mode: 0o644
    FileUtils.install 'dexed.desktop', "#{CREW_DEST_PREFIX}/share/applications", mode: 0o644
  end

  def self.remove
    config_dir = "#{HOME}/.config/dexed"
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
