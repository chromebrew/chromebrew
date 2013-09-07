require './lib/package'

class Glibc < Package
  version '2.17.90-baseline'
  binary_url ({
    i686: "https://dl.dropboxusercontent.com/s/dic47f8eqxhpf89/glibc-2.17.90-baseline-chromeos-i686.tar.gz?token_hash=AAHx_77YtWLLnkjCJRaCJt7RsdKrfkT6lgKS9BZc4O-0Pg&dl=1"
  })
  binary_sha1 ({
    i686: "defebdeeafd71c40193debf3b786938399ece844"
  })
end
