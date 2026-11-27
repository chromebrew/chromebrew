require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.31.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ba33cda8d85b0323780ad450e8038020c7092009c4bb49fbd8251acb8b59dab',
     armv7l: '9ba33cda8d85b0323780ad450e8038020c7092009c4bb49fbd8251acb8b59dab',
       i686: '90fcaee8cc5c2e469abf364349ce92cd575f0e392412db5e276364f26a4c81ab',
     x86_64: '851c042549b2b6b5b788eb7319e871f0d870e7734b70a2aaa6bfc0a40c79c30d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.build
    system 'go build -o bin/bazelisk'
  end

  def self.install
    FileUtils.install 'bin/bazelisk', "#{CREW_DEST_PREFIX}/bin/bazelisk", mode: 0o755
  end
end
