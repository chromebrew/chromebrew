require 'package'

class Cf < Package
  description 'The official command line client for Cloud Foundry'
  homepage 'https://docs.cloudfoundry.org/cf-cli/'
  version '8.18.4'
  license 'Apache-2.0'
  compatibility 'i686 x86_64'
  source_url({
      i686: "https://github.com/cloudfoundry/cli/releases/download/v#{version}/cf8-cli_#{version}_linux_i686.tgz",
    x86_64: "https://github.com/cloudfoundry/cli/releases/download/v#{version}/cf8-cli_#{version}_linux_x86-64.tgz"
  })
  source_sha256({
      i686: 'a7c85c83e07d237c263069146675e9da00d031d2818d570273582f98c197fe78',
    x86_64: '562ce8b06fd76f7b2d7a46af9750ba8729ac8f43838f7f86e7b39cecebea59ba'
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
