require 'package'

class Bazel < Package
  description 'a fast, scalable, multi-language and extensible build system'
  homepage 'https://bazel.build/'
  version '8.0.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/bazelbuild/bazel/releases/download/#{version}/bazel-#{version}-linux-x86_64"
  source_sha256 '40f243b118f46d1c88842315e78ec5f9f6390980d67a90f7b64098613e60d65b'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install "bazel-#{version}-linux-#{ARCH}", "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
