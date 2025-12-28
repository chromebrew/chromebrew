require 'package'

class Missioncenter < Package
  description 'Monitor your CPU, Memory, Disk, Network and GPU usage.'
  homepage 'https://missioncenter.io/'
  version '1.1.0'
  license 'GPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.33'
  # Get the latest at https://gitlab.com/mission-center-devs/mission-center/-/releases.
  source_url 'https://gitlab.com/mission-center-devs/mission-center/-/jobs/12045090460/artifacts/raw/MissionCenter_v1.1.0-x86_64.AppImage'
  source_sha256 '3e38288fb047c78bf38bfc7bf49173032c326f0e511204bf0b3fbd769ed887ed'

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
