require 'package'

class Wget_static < Package
  description 'Static wget 1.x via alpine build'
  homepage 'https://github.com/chromebrew/static-binaries/'
  version '20251015.1'
  license 'GPL-3'
  compatibility 'all'
  source_url({
      aarch64: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_arm64",
       armv7l: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_arm32v7",
         i686: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_i386",
       x86_64: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_amd64"
    })
  source_sha256({
      aarch64: '1992d1929ccc4d7f142a81ae9a9f15193c2340347fa0e8b6620113d2e2000e51',
       armv7l: '17ecea3d89abf1573ebede36ec43259ad1129a047e264d5d43e4421105d113a1',
         i686: 'd1cb28ac167a2e108aaf5df2ffd13ffaaa398394c97326e97b671708ee366d4e',
       x86_64: 'b8a286b93cb70d16b5f63ec362193730ddb10ae96c6ec889b6b1923be6cc10c9'
    })

  conflicts_with 'wget2'
  ignore_updater
  no_compile_needed

  def self.install
    case ARCH
    when 'aarch64'
      FileUtils.install "wget_v#{version}_linux_arm64", "#{CREW_DEST_PREFIX}/bin/wget", mode: 0o755
    when 'armv7l'
      FileUtils.install "wget_v#{version}_linux_arm32v7", "#{CREW_DEST_PREFIX}/bin/wget", mode: 0o755
    when 'i686'
      FileUtils.install "wget_v#{version}_linux_i386", "#{CREW_DEST_PREFIX}/bin/wget", mode: 0o755
    when 'x86_64'
      FileUtils.install "wget_v#{version}_linux_amd64", "#{CREW_DEST_PREFIX}/bin/wget", mode: 0o755
    end
  end
end
