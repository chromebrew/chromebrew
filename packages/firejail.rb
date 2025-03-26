require 'buildsystems/autotools'

class Firejail < Autotools
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.74'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/netblue30/firejail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f4546c5e596cf3f7cddcf4e5457876acbd6526d951d744dfd1d4b07cf06534e',
     armv7l: '4f4546c5e596cf3f7cddcf4e5457876acbd6526d951d744dfd1d4b07cf06534e',
       i686: 'd20f8ff80b1720301d6e66913b91b7ea9f791d655c4c815739b035b1021d7680',
     x86_64: '064c256e5346d784028223236f4beb03df707511f1e444bef418503f443b1aac'
  })

  depends_on 'glibc' # R
end
