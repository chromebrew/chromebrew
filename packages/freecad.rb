require 'package'

class Freecad < Package
  description 'A free and opensource multiplatform 3D parametric modeler.'
  homepage 'https://www.freecadweb.org/'
  version '0.19.2'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url 'https://github.com/FreeCAD/FreeCAD/releases/download/0.19.2/FreeCAD_0.19-24291-Linux-Conda_glibc2.12-x86_64.AppImage'
  source_sha256 'c196a6e59349ed452cc9b9af2c6a0d983a698831630aa5c7077565ed8570c9ad'

  no_compile_needed

  depends_on 'sommelier'

  def self.preflight
    free_space = `echo $(($(stat -f --format="%a*%S" .)))`.chomp.to_i
    abort 'Not enough free disk space.  You need at least 5.2 GB to install.'.lightred if free_space < 5583457485
  end

  def self.patch
    system "sed -i 's,LD_LIBRARY_PATH=\${HERE}/usr/lib,LD_LIBRARY_PATH=\${HERE}/usr/lib:\${LD_LIBRARY_PATH},' AppRun"
  end

  def self.build
    @freecad = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/freecad
      ./AppRun "$@"
    EOF
    File.write('freecad.sh', @freecad)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/freecad"
    FileUtils.install 'freecad.sh', "#{CREW_DEST_PREFIX}/bin/freecad", mode: 0o755
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/freecad"
  end

  def self.postinstall
    puts "\nType 'freecad' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.FreeCAD"
    if Dir.exist? config_dir.to_s
      print "\nWould you like to remove #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir.to_s
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
