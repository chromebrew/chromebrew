require 'package'

class Cf < Package
  description 'The official command line client for Cloud Foundry'
  homepage 'https://docs.cloudfoundry.org/cf-cli/'
  version '8.19.0'
  license 'Apache-2.0'
  compatibility 'i686 x86_64'
  source_url({
      i686: "https://github.com/cloudfoundry/cli/releases/download/v#{version}/cf8-cli_#{version}_linux_i686.tgz",
    x86_64: "https://github.com/cloudfoundry/cli/releases/download/v#{version}/cf8-cli_#{version}_linux_x86-64.tgz"
  })
  source_sha256({
      i686: '7581f1d6e5bc394f779d55b3fdbe154a6ebb55b183f3be5ee957bd6f8fdab0c2',
    x86_64: '98268ab3134bb3a1c97ffce797b4e6d35590a82e006cd098ad7a29f0a5cae7d8'
  })

  no_compile_needed
  print_source_bashrc

  def self.build
    # There isn't a version for cf8...
    downloader 'https://raw.githubusercontent.com/cloudfoundry/cli-ci/main/ci/installers/completion/cf7',
               '7ee78e471d6924b81e9062083e1ad13be2b18e70135a7cc9da9b75f5984c0fee', 'cf.bash'
    cf_major_version = version.split('.').first
    file = File.read('cf.bash')
    file.sub!('cf7', "cf#{cf_major_version}")
    File.write('cf.bash', file)
    File.write '10-cf', <<~EOF
      # Cloud Foundry CLI configuration
      source #{CREW_PREFIX}/share/cf/bash-completion/cf.bash
    EOF
  end

  def self.install
    FileUtils.install 'cf', "#{CREW_DEST_PREFIX}/bin/cf", mode: 0o755
    FileUtils.install '10-cf', "#{CREW_DEST_PREFIX}/etc/bash.d/10-cf", mode: 0o644
    FileUtils.install 'cf.bash', "#{CREW_DEST_PREFIX}/share/cf/bash-completion/cf.bash", mode: 0o644
  end
end
