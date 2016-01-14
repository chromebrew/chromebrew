require 'package'

class Node_stable < Package
  version '5.4.1'
  binary_url ({
    i686: "https://nodejs.org/dist/v5.4.1/node-v5.4.1-linux-x64.tar.xz",
    x86_64: "https://nodejs.org/dist/v5.4.1/node-v5.4.1-linux-x86.tar.xz"
  })
  binary_sha1 ({
    i686: "39c4e3f5f78849aba02c02f49a9093898c52b933",
    x86_64: "f7aaac398450a383958b2ecffa987adbec179a18"
  })
end

