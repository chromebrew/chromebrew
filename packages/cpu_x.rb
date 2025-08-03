require 'package'

class Cpu_x < Package
  description 'CPU-X is a Free software that gathers information on CPU, motherboard and more.'
  homepage 'https://thetumultuousunicornofdarkness.github.io/CPU-X/'
  version '5.3.1'
  license 'GPL-3'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://github.com/TheTumultuousUnicornOfDarkness/CPU-X/releases/download/#{version}/CPU-X-#{version}-x86_64.AppImage"
  source_sha256 '4be4fbc8c29c0f67851f7f6c2a3eaa31bd3d818089d19ec69fa1682da1b70937'

  gnome
  no_compile_needed

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    File.write 'cpu-x.sh', <<~EOF
      #!/bin/bash
      export LD_LIBRARY_PATH="#{CREW_PREFIX}/share/cpu-x/usr/lib:$LD_LIBRARY_PATH"
      cd #{CREW_PREFIX}/share/cpu-x
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/cpu-x"
    FileUtils.install 'cpu-x.sh', "#{CREW_DEST_PREFIX}/bin/cpu-x", mode: 0o755
    FileUtils.mv Dir['AppDir/*'], "#{CREW_DEST_PREFIX}/share/cpu-x"
  end

  def self.postinstall
    ExitMessage.add "\nType 'cpu-x' to get started.\n"
  end
end
