require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '2.3.35'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://bin.equinox.io/a/dFJfzZziYxC/ngrok-2.3.35-linux-arm.tar.gz'
    source_sha256 '2721e6d74f7d26f061c96df3b5676f32cf4b94a5b43d44d9a535f777dc0b863e'
  when 'i686'
    source_url 'https://bin.equinox.io/a/3BwMsheYHot/ngrok-2.3.35-linux-386.tar.gz'
    source_sha256 '12c79750c1d5d78c9924d56e448ae5ceb78fe06bfc3d724ed9028b02b0cda56b'
  when 'x86_64'
    source_url 'https://bin.equinox.io/a/jAq5uX8wfS8/ngrok-2.3.35-linux-amd64.tar.gz'
    source_sha256 '55df9c479b41a3b9b488458b5fb758df63001d14196a4126e3f669542c8727e9'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 ngrok #{CREW_DEST_PREFIX}/bin/ngrok"
  end
end
