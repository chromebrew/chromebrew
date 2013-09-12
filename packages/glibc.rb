require 'package'

class Glibc < Package
  version '2.17.90-baseline'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/dic47f8eqxhpf89/glibc-2.17.90-baseline-chromeos-i686.tar.gz?token_hash=AAHx_77YtWLLnkjCJRaCJt7RsdKrfkT6lgKS9BZc4O-0Pg&dl=1"
  })
  binary_sha1 ({
    i686: "3c3a0b86ed4591ec59daeb24d2dcda139574de1b"
  })
end
