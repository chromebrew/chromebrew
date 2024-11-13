require 'package'

class Bazel < Package
  description 'a fast, scalable, multi-language and extensible build system'
  homepage 'https://bazel.build/'
  version '7.4.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/bazelbuild/bazel/releases/download/#{version}/bazel-#{version}-linux-x86_64"
  source_sha256 '48ea0ff9d397a48add6369c261c5a4431fe6d5d5348cfb81411782fb80c388d3'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install "bazel-#{version}-linux-#{ARCH}", "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
