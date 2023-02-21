require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.16.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/bazelbuild/bazelisk/releases/download/v1.16.0/bazelisk-linux-amd64'
  source_sha256 '168851e70cf5f95c0e215e7f3aaca5132ffc3c8dd8f585a4157b0be2b53cfe32'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'bazelisk-linux-amd64', "#{CREW_DEST_PREFIX}/bin/bazelisk", mode: 0o755
  end
end
