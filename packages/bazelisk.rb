require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.24.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2756cd2dfe626bf78e6b3b5cc86787b82ee045d150176fd08830ca024710b85f',
     armv7l: '2756cd2dfe626bf78e6b3b5cc86787b82ee045d150176fd08830ca024710b85f',
       i686: '84ef6280314b876938c6f08f1c5c144e0e8bbf3629910f9a63d7224196dc8d36',
     x86_64: 'cb4a70e4431b48584d8443dc7006ce528c4971cc436da0ba4adbeacbf73f3ee6'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.build
    system 'go build -o bin/bazelisk'
  end

  def self.install
    FileUtils.install 'bin/bazelisk', "#{CREW_DEST_PREFIX}/bin/bazelisk", mode: 0o755
  end
end
