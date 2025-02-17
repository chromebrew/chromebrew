require 'package'

class Bazel < Package
  description 'a fast, scalable, multi-language and extensible build system'
  homepage 'https://bazel.build/'
  version '8.1.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/bazelbuild/bazel/releases/download/#{version}/bazel-#{version}-linux-x86_64"
  source_sha256 'b4bae524f58e00a69f7c6fa10e62a91f85bfee586105dd480dccb4300c7cbca5'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install "bazel-#{version}-linux-#{ARCH}", "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
