require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.48.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dba5cb62bee34d23b88b51c7ec883ec8af251036afee69d6c045a59ee71fe259',
     armv7l: 'dba5cb62bee34d23b88b51c7ec883ec8af251036afee69d6c045a59ee71fe259',
       i686: 'ae5890f31fd6552189865dc06d48dc76c901bf9580b7ebac5d5458d5f753bd71',
     x86_64: 'bc878c7526704a58e81c0741721842000c9e4afd6cca1716ab848ebc9440843a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
