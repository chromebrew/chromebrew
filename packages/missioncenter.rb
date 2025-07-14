require 'package'

class Missioncenter < Package
  description 'Monitor your CPU, Memory, Disk, Network and GPU usage.'
  homepage 'https://missioncenter.io/'
  version '1.0.2'
  license 'GPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.33'
  source_url "https://gitlab.com/mission-center-devs/mission-center/-/jobs/10144675634/artifacts/raw/MissionCenter_v#{version}-x86_64.AppImage"
  source_sha256 'b2db5dc8a7f9d87cff764995d7469648c1e75f2bae59c62295fc3a95e9a2f86f'

  depends_on 'librsvg'

  no_compile_needed
  no_shrink

  def self.build
    File.write 'missioncenter.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/missioncenter
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/missioncenter"
    FileUtils.install 'missioncenter.sh', "#{CREW_DEST_PREFIX}/bin/missioncenter", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/missioncenter"
  end

  def self.postinstall
    ExitMessage.add "\nType 'missioncenter' to get started.\n"
  end
end
