require 'package'

class Openssl < Package
  version '1.0.1e'
  binary_url ({
    i686: 'https://dl.dropboxusercontent.com/s/w6y84tusor5xz5f/openssl-1.0.1e-chromeos-i686.tar.gz?token_hash=AAGQ2xjngbnzme2CKee7Mz5WvkylBtFy1rwUzWDVNuOQ_Q&dl=1',
    x86_64: 'https://dl.dropboxusercontent.com/s/384awniosicvm12/openssl-1.0.1e-chromeos-x86_64.tar.gz?token_hash=AAH4sdqkNnhIFU-uPdrpqddsi8UU0vWe_gwkplUBM_40MQ&dl=1'
  })
  binary_sha1 ({
    i686: 'cadea32ec770c4b44d565b7e5fdf96a469a05757',
    x86_64: '3cf4defb11fc2fccce77736d0f4559e56d9d7e05'
  })
end
