require 'package'

class Aws < Package
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  version '1.19.53'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/aws-1.19.53-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/aws-1.19.53-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/aws-1.19.53-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/aws-1.19.53-chromeos-x86_64.tar.xz',
  })
  binary_sha256({
    aarch64: '4697a774c31755e1fa19e76eb567dd7661392cdee69983b990452d2b3871fd3c',
     armv7l: '4697a774c31755e1fa19e76eb567dd7661392cdee69983b990452d2b3871fd3c',
       i686: '8b0849272c984f17d5f9c670b3d878767757d1e9161939dd4d8bde9b713f7a10',
     x86_64: 'd02cbc9b1abfbc13875d291ef2cdd7cac1fe6cea0b3adfb5746a0fdff7382bff',
  })

  depends_on 'groff'
  depends_on 'setuptools' => :build

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} \
    -I awscli==#{version} --single-version-externally-managed --no-warn-script-location"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    @awsbashrc = <<~AWSBASHRCEOF
      # Amazon Web Services CLI bash completion
      source #{CREW_PREFIX}/bin/aws_bash_completer
    AWSBASHRCEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/aws", @awsbashrc)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/zsh.d"
    @awszshrc = <<~AWSZSHRCEOF
      # Amazon Web Services CLI zsh completion
      source #{CREW_PREFIX}/bin/aws_zsh_completer.sh
    AWSZSHRCEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/zsh.d/aws", @awszshrc)
  end
end
