require 'package'

class Mpc < Package
  version '1.0.1'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/3o6uc8n4uy3oved/mpc-1.0.1-chromeos-i686.tar.gz?token_hash=AAH_OlvQWGUF7lyFhV3DXXgYRM1fupgKoHIwyiVmmVyWUQ&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/qr1x2fr1z0af26o/mpc-1.0.1-chromeos-x86_64.tar.gz?token_hash=AAFGK8OM8sm4k02lBAudZg8olgKxs_HmieFFqU6MZZONOA&dl=1',
    armv7l: 'https://www.dropbox.com/s/bne8sqylj30w7ca/mpc.tar.gz?dl=0'
  })
  binary_sha1 ({
    i686: 'f11c6e74e9059bf400b0978e6e05fe67c7f3dfe9',
    x86_64: '24c4be4ea026d2d6e432a0aa9edb6dd27cf3e7df',
    armv7l: '73ccafa5184ba1953d0fd4d7b861e72734b99c12'
  })
end
