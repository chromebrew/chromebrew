require 'package'

class Freetube < Package
  description 'The Private YouTube Client'
  homepage 'https://freetubeapp.io/'
  version '0.21.1'
  license 'AGPL-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-linux-portable-armv7l.zip",
     armv7l: "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-linux-portable-armv7l.zip",
     x86_64: "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-linux-portable-x64.zip"
  })
  source_sha256({
    aarch64: '0ba80c3a9bebbeffd8993a9916e1a0c89cf204db367c07d1c71d35de009b2fae',
     armv7l: '0ba80c3a9bebbeffd8993a9916e1a0c89cf204db367c07d1c71d35de009b2fae',
     x86_64: '7038609feef16f68f60a7258f421f4b7e0c21825ea8beb0c0a7aa47139698f29'
  })

  depends_on 'gtk3'
  depends_on 'xdg_utils'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/freetube"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/freetube"
    FileUtils.ln_s "#{CREW_PREFIX}/share/freetube/freetube", "#{CREW_DEST_PREFIX}/bin/freetube"
  end

  def self.postinstall
    ExitMessage.add "\nType 'freetube' to get started.\n"
  end
end
