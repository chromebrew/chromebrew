require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.30.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e2a02528dde5da4b17457b7aae242ab9471d0a7bf9e757b28409e84d7acb652',
     armv7l: '4e2a02528dde5da4b17457b7aae242ab9471d0a7bf9e757b28409e84d7acb652',
       i686: 'e3ef38e305f74c1d6a51ac6c001afe266d8a2c79aad18e000238f6c9edcdd22a',
     x86_64: 'e3580b41faeab3b90233622f9f535fccc3301c8ead25dbfa3eb7c258fcf7f7d4'
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
