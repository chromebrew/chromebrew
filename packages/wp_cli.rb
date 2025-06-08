require 'package'

class Wp_cli < Package
  description 'The command line interface for WordPress'
  homepage 'https://wp-cli.org/'
  version '2.12.0'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/wp-cli/wp-cli/releases/download/v#{version}/wp-cli-#{version}.phar"
  source_sha256 'ce34ddd838f7351d6759068d09793f26755463b4a4610a5a5c0a97b68220d85c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '853e6d80abefe05d1a1f671f7df78fbc7ee3104c8f36fc183d5b11f8d45620d3',
     armv7l: '853e6d80abefe05d1a1f671f7df78fbc7ee3104c8f36fc183d5b11f8d45620d3',
     x86_64: 'a8f3a8b23c8c52488ce8aacb165cea88db99a9d9eff2680776c46c50846069a7'
  })

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.install "wp-cli-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/wp", mode: 0o755
  end
end
