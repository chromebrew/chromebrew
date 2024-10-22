require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.21.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '160aa76151bf734680b8576d1580922ec3e9315eb7401a5f17cd935107e8624d',
     armv7l: '160aa76151bf734680b8576d1580922ec3e9315eb7401a5f17cd935107e8624d',
       i686: 'fa61c794cc379df68746a30e7b4965972d7bbb4b600b557665c3bfedcf0b4e88',
     x86_64: '5bb2e89fe043b3137913c635cdf15fc9756116797298caef275619186c031a98'
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
