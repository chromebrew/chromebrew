require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '2.3.15'
  compatibility 'all'
  case ARCH
  when 'aarch64'
    source_url 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip'
    source_sha256 'd7c1beab61690cf83be3fc4e26880806e3c2ebbe6357182457f4cad22ae033de'
  when 'armv7l'
    source_url 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip'
    source_sha256 'd7c1beab61690cf83be3fc4e26880806e3c2ebbe6357182457f4cad22ae033de'
  when 'i686'
    source_url 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip'
    source_sha256 'e8b8b033b4aec785e0ba1e5ce5893982fc9740aeb2006b1f9c2d2a906f5884f9'
  when 'x86_64'
    source_url 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip'
    source_sha256 '45d8a9e10abff1c77210acc0c123cdea3b7fbce7cfc1a06138c6392379775b17'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 ngrok #{CREW_DEST_PREFIX}/bin/ngrok"
  end
end
