require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.28.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e604f11a477794e16d5586c96c4d20c4f1b894c3265eb56da683a236d588fbeb',
     armv7l: 'e604f11a477794e16d5586c96c4d20c4f1b894c3265eb56da683a236d588fbeb',
       i686: '268f9b58282c186b8a6d6a84c6d5cfcca934ebf7f57247a6ec286389bab6ae59',
     x86_64: '248b90f3956d890e627fa3363b3ca521fe3bd801a050514ab0331359bb898162'
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
