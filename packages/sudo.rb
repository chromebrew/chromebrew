require 'package'

class Sudo < Package
  description 'Sudo (su "do") allows a system administrator to delegate authority to give certain users (or groups of users) the ability to run some (or all) commands as root or another user while providing an audit trail of the commands and their arguments.'
  homepage 'https://www.sudo.ws/'
  version '1.8.23'
  source_url 'https://www.sudo.ws/repos/sudo/raw-rev/SUDO_1_8_23'
  source_sha256 '95dd4ea4b503dad82f7ef36f7fab350e5d748991f54e17755574d9ca61c91cff'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    # Make sure sudo is using the root user PATH.
    # See https://unix.stackexchange.com/questions/83191/how-to-make-sudo-preserve-path.
    system "echo '#!/bin/bash' > sudo"
    system "echo '/usr/bin/sudo env PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin \"\$@\"' >> sudo"
  end

  def self.install
    system "install -Dm755 sudo #{CREW_DEST_PREFIX}/bin/sudo"
  end
end
