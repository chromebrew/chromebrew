require 'package'

class Bazel < Package
  description 'a fast, scalable, multi-language and extensible build system'
  homepage 'https://bazel.build/'
  version '9.0.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/bazelbuild/bazel/releases/download/#{version}/bazel-#{version}-linux-x86_64"
  source_sha256 'b4746d3ee7e698b08ebc6a91bd6b4062a25d1b4214a5964f866986f59fc159fb'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install "bazel-#{version}-linux-#{ARCH}", "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
