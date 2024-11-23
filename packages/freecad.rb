require 'package'
require 'misc_functions'

class Freecad < Package
  description 'A free and opensource multiplatform 3D parametric modeler.'
  homepage 'https://www.freecad.org/'
  version '1.0.0'
  license 'GPL-2'
  compatibility 'x86_64'
  source_url "https://github.com/FreeCAD/FreeCAD/releases/download/#{version}/FreeCAD_#{version}-conda-Linux-x86_64-py311.AppImage"
  source_sha256 '4b1c53e7f444a7897875064e059be84c0ebb8848dd58bc034dcdd1ccc407dbc7'

  no_compile_needed
  no_shrink

  depends_on 'sommelier'

  def self.preflight
    MiscFunctions.check_free_disk_space(5583457485)
  end

  def self.patch
    system "sed -i 's,LD_LIBRARY_PATH=\${HERE}/usr/lib,LD_LIBRARY_PATH=\${HERE}/usr/lib:\${LD_LIBRARY_PATH},' AppRun"
  end

  def self.build
    File.write 'freecad.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/freecad
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.install 'freecad.sh', "#{CREW_DEST_PREFIX}/bin/freecad", mode: 0o755
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/freecad"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/freecad"
  end

  def self.postinstall
    ExitMessage.add "\nType 'freecad' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.cache/FreeCAD")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/FreeCAD")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/.local/share/FreeCAD")
  end
end
