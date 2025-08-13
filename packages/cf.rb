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
       i686: '0b55f6b6a801b3095a45665d7fb397e29fd6646798c723388f6f8c4bce0ed67a',
     x86_64: 'cae05d3f907afe8631945d30804d72572b4fe426a55c98ef9be2678f54e8bd1e'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/cf/bash-completion/"
    FileUtils.install 'cf', "#{CREW_DEST_PREFIX}/bin/cf", mode: 0o755
    system 'curl -#Lo cf.bash https://raw.githubusercontent.com/cloudfoundry/cli/v6.36.1/ci/installers/completion/cf'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('cf.bash')) == 'f3f05a2414075c00b101b05f73cf260b9eec9966659adf2957c1b2937bd4c48e'
    FileUtils.install 'cf.bash', "#{CREW_DEST_PREFIX}/share/cf/bash-completion/cf.bash", mode: 0o644
    @env = <<~EOF
      # Cloud Foundry CLI configuration
      source #{CREW_PREFIX}/share/cf/bash-completion/cf.bash
    EOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/cf", @env)
  end
end
