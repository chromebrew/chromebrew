require 'package'

class Bazel < Package
  description 'a fast, scalable, multi-language and extensible build system'
  homepage 'https://bazel.build/'
  version '7.4.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/bazelbuild/bazel/releases/download/#{version}/bazel-#{version}-linux-x86_64"
  source_sha256 'c97f02133adce63f0c28678ac1f21d65fa8255c80429b588aeeba8a1fac6202b'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install "bazel-#{version}-linux-#{ARCH}", "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
