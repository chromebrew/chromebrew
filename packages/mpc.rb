require 'package'

class Mpc < Package
  version '1.0.1'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/l302ru0xdq9qtsu/mpc-1.0.1-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/3o6uc8n4uy3oved/mpc-1.0.1-chromeos-i686.tar.gz?token_hash=AAH_OlvQWGUF7lyFhV3DXXgYRM1fupgKoHIwyiVmmVyWUQ&dl=1",
    x86_64: "https://dl.dropboxusercontent.com/s/qr1x2fr1z0af26o/mpc-1.0.1-chromeos-x86_64.tar.gz?token_hash=AAFGK8OM8sm4k02lBAudZg8olgKxs_HmieFFqU6MZZONOA&dl=1"
  })
  binary_sha1 ({
    armv7l: "861960c75696ff613a410e3a1ab406c7128a790c",
    i686: "f11c6e74e9059bf400b0978e6e05fe67c7f3dfe9",
    x86_64: "24c4be4ea026d2d6e432a0aa9edb6dd27cf3e7df"
  })
end
