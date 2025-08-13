require 'package'

class Cf < Package
  description 'The official command line client for Cloud Foundry'
  homepage 'https://docs.cloudfoundry.org/cf-cli/'
  version '8.14.1'
  license 'Apache-2.0'
  compatibility 'i686 x86_64'
  case ARCH
  when 'i686'
    source_url "https://github.com/cloudfoundry/cli/releases/download/v#{version}/cf8-cli_#{version}_linux_i686.tgz"
    source_sha256 '92d2960b950d16387c8fa9c8d5e279708930734daa5cf2ba905e0b640ed4799d'
  when 'x86_64'
    source_url "https://github.com/cloudfoundry/cli/releases/download/v#{version}/cf8-cli_#{version}_linux_x86-64.tgz"
    source_sha256 'c605b0737690efe2d33d642939589737955251c85f0633b59b67a8742b08fceb'
  end
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '05ac4ed0ef3fd18a206d618f245d40f9c968211b661ef3222eaf743668e8027c',
     x86_64: '8465927ec7f43c661e11fcbbe939969f86ece4d9b28de20d58b6681f862a2825'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/cf/bash-completion/"
    FileUtils.install 'cf', "#{CREW_DEST_PREFIX}/bin/cf", mode: 0o755
    # There isn't a version for cf8...
    downloader 'https://raw.githubusercontent.com/cloudfoundry/cli-ci/main/ci/installers/completion/cf7', '7ee78e471d6924b81e9062083e1ad13be2b18e70135a7cc9da9b75f5984c0fee', 'cf.bash'
    cf_major_version = version.split('.').first
    file = File.read('cf.bash')
    file.sub!('cf7', "cf#{cf_major_version}")
    File.write('cf.bash', file)
    FileUtils.install 'cf.bash', "#{CREW_DEST_PREFIX}/share/cf/bash-completion/cf.bash", mode: 0o644
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/cf", <<~EOF
      # Cloud Foundry CLI configuration
      source #{CREW_PREFIX}/share/cf/bash-completion/cf.bash
    EOF
  end
end
