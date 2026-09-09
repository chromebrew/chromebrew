require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.50.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa55a9259cc60cdf0ad39bf0a068c43cef2d9d6438e1e90fce8e99f0119864c2',
     armv7l: 'aa55a9259cc60cdf0ad39bf0a068c43cef2d9d6438e1e90fce8e99f0119864c2',
       i686: 'a2eb047307f806cee3fcee15b4808d5371d7a21861dd363a917be90c683bc81f',
     x86_64: '001d2f1f85fec04010cf34e2f5141eaa1a998907f1ca215b8c5431bb52f34942'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
