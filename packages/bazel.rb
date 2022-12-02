require 'package'

class Bazel < Package
  description 'a fast, scalable, multi-language and extensible build system'
  homepage 'https://bazel.build/'
  version '5.3.2'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/bazelbuild/bazel/releases/download/5.3.2/bazel-5.3.2-linux-x86_64'
  source_sha256 '973e213b1e9207ccdd3ea4730c0f92cbef769ec112ac2b84980583220d8db845'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install "bazel-#{version}-linux-#{ARCH}", "#{CREW_DEST_PREFIX}/bin/bazel", mode: 0o755
  end
end
