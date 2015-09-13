require 'package'

class Zlibpkg < Package
  version '1.2.8'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/ljhhvr12u1izayj/zlib-1.2.8-chromeos-i686.tar.gz?token_hash=AAEABTatYkxOOybZGoCj3Kg_DKEbFbSfolzZklfHwCsP_A&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/h4lqj0rnand0jqu/zlib-1.2.8-chromeos-x86_64.tar.gz?token_hash=AAGabAMhX4CGpzhpkcuKMmmWPxFZDiNOC-r9B0o7x4D7eQ&dl=1',
    armv7l: 'https://www.dropbox.com/s/dnp7xot5jst9dy0/zlib.tar.gz?dl=0'
  })
  binary_sha1 ({
    i686: 'e02974780bfb3bf46940183043d15897a765ab4e',
    x86_64: 'cb764e22b68b7e2884372708b5b585d11efca972',
    armv7l: '5895729016e16747e12989d1194b376efe310da1'
  })
end
