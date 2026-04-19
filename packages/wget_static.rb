require 'package'

class Wget_static < Package
  description 'Static wget 1.x via alpine build'
  homepage 'https://github.com/chromebrew/static-binaries/'
  version '20260301.1'
  license 'GPL-3'
  compatibility 'all'
  source_url({
      aarch64: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_arm64",
       armv7l: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_arm32v7",
         i686: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_i386",
       x86_64: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/wget_v#{version}_linux_amd64"
    })
  source_sha256({
      aarch64: '2a7cdfae68e5a001e28d2749002ec7dc6ebd8c5401d58803d39c88b836d817bb',
       armv7l: '02452458055730b45d95c789521e423d2b04e322fcbe4e75a3a6e25a2a6c15db',
         i686: '806a8f0f6aa843275a2f11876f54fea747148d0d188cd655ff6557420d934a1c',
       x86_64: '114105ee626367833f3f70410fb639ce54e09cecc0ca864eeae0938cbff1b2a4'
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
