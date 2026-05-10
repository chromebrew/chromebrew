require 'package'

class Curl_static < Package
  description 'Static curl 8.x via alpine build'
  homepage 'https://github.com/chromebrew/static-binaries/'
  version '20260301.1'
  license 'GPL-3'
  compatibility 'all'
  source_url({
      aarch64: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/curl_v#{version}_linux_arm64",
       armv7l: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/curl_v#{version}_linux_arm32v7",
         i686: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/curl_v#{version}_linux_i386",
       x86_64: "https://github.com/chromebrew/static-binaries/releases/download/v#{version}/curl_v#{version}_linux_amd64"
    })
  source_sha256({
      aarch64: '2f8b71fcc54be75eb12fafaa7275c3407a0bbe454747c550bd70a39e132a703c',
       armv7l: '95ebdc40fc11261e0675575973705c097f42bd8a7ab09c22f18b01cd7bbf49dc',
         i686: '1299836a610ad2ea8f51670e20d43e1c0a8ebc00d1f757deeb7c195fb37d4964',
       x86_64: '7cdd59b027cd1f01cd23a20dcadbbdead992a78ef035accebd999ccb7f84080c'
    })

  ignore_updater
  no_compile_needed

  def self.install
    case ARCH
    when 'aarch64'
      FileUtils.install "curl_v#{version}_linux_arm64", "#{CREW_DEST_PREFIX}/bin/curl_static", mode: 0o755
    when 'armv7l'
      FileUtils.install "curl_v#{version}_linux_arm32v7", "#{CREW_DEST_PREFIX}/bin/curl_static", mode: 0o755
    when 'i686'
      FileUtils.install "curl_v#{version}_linux_i386", "#{CREW_DEST_PREFIX}/bin/curl_static", mode: 0o755
    when 'x86_64'
      FileUtils.install "curl_v#{version}_linux_amd64", "#{CREW_DEST_PREFIX}/bin/curl_static", mode: 0o755
    end
  end
end
