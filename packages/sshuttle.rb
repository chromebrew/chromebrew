require 'package'

class Sshuttle < Package
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle'
  version '0.78.3'
  source_url 'https://github.com/sshuttle/sshuttle/archive/v0.78.3.tar.gz'
  source_sha256 '62c18b4d89e654687247a334e0ebaec675d38dfbedc6863d8d65044d37241b0f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.build
    nil
  end

  def self.install
    system "pip3 install sshuttle --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
