require 'buildsystems/autotools'

class Firejail < Autotools
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.82.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/netblue30/firejail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09aa0b31941d3aefd375d3128c2325a6cf908ce00db7efe088ab614c752d0914',
     armv7l: '09aa0b31941d3aefd375d3128c2325a6cf908ce00db7efe088ab614c752d0914',
     x86_64: 'cfd8beca9d53edc52ff58ebdacd8d712ac68bd58dc8da7203c3d0395c112a915'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  # Unable to build i686: src/lib/syscall.c:913:9: error: expected expression before ‘}’ token
end
