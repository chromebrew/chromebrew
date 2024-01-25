require 'package'

class Cf < Package
  description 'The official command line client for Cloud Foundry'
  homepage 'https://docs.cloudfoundry.org/cf-cli'
  version '6.53.0'
  license 'Apache-2.0'
  compatibility 'i686 x86_64'
  case ARCH
  when 'i686'
    source_url 'https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v6.53.0/cf-cli_6.53.0_linux_i686.tgz'
    source_sha256 'bd4620f116bfd3093fb6f5c20ceab94be32539839b615223b65bc14d75dae27b'
  when 'x86_64'
    source_url 'https://s3-us-west-1.amazonaws.com/cf-cli-releases/releases/v6.53.0/cf-cli_6.53.0_linux_x86-64.tgz'
    source_sha256 '09664d1469fb8a0ddba804343121aba7d8f64ba6bfde75a53f6e29d6600b2342'
  end
  binary_compression 'tar.xz'

  binary_sha256({
    i686: 'bd74201bfadd439ea2e65827c8c6ff725bbd70a7931efe90e6f97b4628e10b8e',
    x86_64: '1607f02390272191a8a0c393a9a5a9cf5389df774e158bd2cb669b0edd5c3570'
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
