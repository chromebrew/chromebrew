require 'package'

class Aws2 < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '0.2.7'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/8e/d4/56cec0935aef056e6d20581b09c64d6e6395dc3ff381ec89e7c8e7f6667f/aws2-0.2.7.tar.gz'
  source_sha256 'e7f09c31b8c152ea015a002c2f2dc8745f0e2ec01cc21cc5fd92afb6b97e24a4'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws2-0.2.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws2-0.2.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws2-0.2.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws2-0.2.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '72215a5bbb0b6f63fa31492d89fe54e17630b505a64f89e37720823c3c346de3',
     armv7l: '72215a5bbb0b6f63fa31492d89fe54e17630b505a64f89e37720823c3c346de3',
       i686: '1420037e0c3b280a52d31c1ebcd6414449af5639df9beee939e612f16de9412f',
     x86_64: 'd966588d9e78c2de23bf36800f46fa084aed2cd2603c417f24d1adba06024f9e'
  })

  depends_on 'setuptools' => :build
  depends_on 'six'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I aws2==#{version} --no-warn-script-location"

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
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/aws", @awszshrc)
  end
end
