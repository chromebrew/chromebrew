require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.29.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cacd175ba9337e7a7ed58c2887351e1f06746fe19b1c529ae7bd9f476c8c6796',
     armv7l: 'cacd175ba9337e7a7ed58c2887351e1f06746fe19b1c529ae7bd9f476c8c6796',
       i686: '21cc20127c447289d5e48556c360320319aa1884fb917357d3a39925eb3100f1',
     x86_64: '64c35a1e2ded012548f1a6e4a71f8509e25dc2fb6251e5220cf004ec25575496'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  def self.build
    system 'go build -o bin/bazelisk'
  end

  def self.install
    FileUtils.install 'bin/bazelisk', "#{CREW_DEST_PREFIX}/bin/bazelisk", mode: 0o755
  end
end
