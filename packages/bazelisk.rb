require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.28.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '405ed0d8d343a3c019496e24ab84cab15939d360e4e47f5a71e69443ed9ff87b',
     armv7l: '405ed0d8d343a3c019496e24ab84cab15939d360e4e47f5a71e69443ed9ff87b',
       i686: 'd7c131a2d99c935e1e2bc4c08c45f706365d0d5c066aab7eef70a251ea52efbe',
     x86_64: '8bf9d7d3d45a1199eaf07bf43ed36b014cb99fcf8117ddc7b5f4d8263a3bee96'
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
