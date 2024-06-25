require 'package'

class Freetube < Package
  description 'The Private YouTube Client'
  homepage 'https://freetubeapp.io/'
  version '0.21.0'
  license 'AGPL-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-linux-portable-armv7l.zip",
     armv7l: "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-linux-portable-armv7l.zip",
     x86_64: "https://github.com/FreeTubeApp/FreeTube/releases/download/v#{version}-beta/freetube-#{version}-linux-portable-x64.zip"
  })
  source_sha256({
    aarch64: '4a4c2141f6a8b49fecc3eb2f1cea42738e21005c2b6a1577cdb75ae35b5c1c9a',
     armv7l: '4a4c2141f6a8b49fecc3eb2f1cea42738e21005c2b6a1577cdb75ae35b5c1c9a',
     x86_64: '9475e5e619f7e869a968b201e435499a3d6752d1aeacd3e11bd29173de1c43c9'
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
    ExitMessage.add "\nType 'freetube' to get started.\n".lightblue
  end
end
