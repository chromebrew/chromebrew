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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })
end
