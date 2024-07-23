require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.20.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/bazelbuild/bazelisk/releases/download/v#{version}/bazelisk-linux-amd64"
  source_sha256 'd9af1fa808c0529753c3befda75123236a711d971d3485a390507122148773a3'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bazelisk-linux-amd64', "#{CREW_DEST_PREFIX}/bin/bazelisk", mode: 0o755
  end
end
