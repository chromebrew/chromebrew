require 'package'

class Mpc < Package
  version '1.0.3'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/v86dgj7tut6wnty/mpc-1.0.3-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/oewxjj9cx5f879m/mpc-1.0.3-chromeos-i686.tar.xz",
    x86_64: "https://dl.dropboxusercontent.com/s/vk1qr1t0yisgqt6/mpc-1.0.3-chromeos-x86_64.tar.xz",
  })
  binary_sha1 ({
    armv7l: "2a05a536cc6fd4da7d948c4732722c5d430ee010",
    i686: "f10689f81749d65d1741f801387e9970eea988d7",
    x86_64: "659123c6bf218d60837579e1fe50dd86f24d487f",
  })
end
