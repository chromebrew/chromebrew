require 'package'

class Jgrasp < Package
  description 'jGRASP is a lightweight development environment, created specifically to provide automatic generation of software visualizations to improve the comprehensibility of software.'
  homepage 'https://www.jgrasp.org/'
  version '206.19'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.jgrasp.org/dl4g/jgrasp/jgrasp#{version.sub('.', '_')}.zip"
  source_sha256 'c1e4161699677b3d7b147ffe0303f68254c41f0bae68308f79e352c48fd6bd59'

  depends_on 'gtk3'
  depends_on 'openjdk17'
  depends_on 'unzip'

  no_compile_needed

  def self.build
    File.write 'jgrasp.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/jgrasp
      bin/jgrasp "$@"
    EOF
    File.write 'jGRASP.desktop', <<~EOF
      [Desktop Entry]
      Encoding=UTF-8
      Version=1.0
      Name[en_US]=jGRASP
      NGenericName=IDE
      Exec=#{CREW_PREFIX}/bin/jgrasp
      Terminal=false
      Icon=#{CREW_PREFIX}/share/icons/gric48.png
      Type=Application
      Categories=Application;Development;IDE;
      Comment[en_US]=jGRASP IDE
    EOF
  end

  def self.patch
    # Remove Windows executables.
    system "find -name '*.bat' -exec rm {} +"
    system "find -name '*.exe' -exec rm {} +"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jgrasp"
    FileUtils.install 'jgrasp.sh', "#{CREW_DEST_PREFIX}/bin/jgrasp", mode: 0o755
    FileUtils.install 'jGRASP.desktop', "#{CREW_DEST_PREFIX}/share/applications/jGRASP.desktop", mode: 0o644
    FileUtils.mv Dir['data/*.png'], "#{CREW_DEST_PREFIX}/share/icons"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/jgrasp"
  end

  def self.postinstall
    ExitMessage.add "\nType 'jgrasp' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.grasp_settings")
  end
end
