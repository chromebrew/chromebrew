require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.39.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '489f8887e565982acc7101addfd275ca6c4cbd8fedee0ce400f8f9823f9ab0f3',
     armv7l: '489f8887e565982acc7101addfd275ca6c4cbd8fedee0ce400f8f9823f9ab0f3',
       i686: '2823d076fdbcca9ad38a463f7024bffc7f61db0bd91d91ee884ded61f7591137',
     x86_64: '9436c12f13b3b60f1b3897434b923d944a4709b4855256060379a206656407b8'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
