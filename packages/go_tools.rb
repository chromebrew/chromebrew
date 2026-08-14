require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.49.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70842d29ab6747ad85c667454bed022396374468cadad26bf82a3f5c95140905',
     armv7l: '70842d29ab6747ad85c667454bed022396374468cadad26bf82a3f5c95140905',
       i686: '6a9e823c3d26903f5c56de8763ac9b9807c48fae016c483e86037537509651e9',
     x86_64: '235c44fbc28353fbd598db05e955c3242805ee6f7a1d1172c351cfda5b3f426a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
