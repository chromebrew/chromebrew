require 'buildsystems/autotools'

class Firejail < Autotools
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.80'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/netblue30/firejail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af74a94f93d8fd22c686d17b00378350bc60a7e9a4c1f1287d3b24203de0f6cb',
     armv7l: 'af74a94f93d8fd22c686d17b00378350bc60a7e9a4c1f1287d3b24203de0f6cb',
     x86_64: '0f70f2fd03e79e6679588f01c67ec66342f2cd9c6795e2cc4476286861c5c4b1'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  # Unable to build i686: src/lib/syscall.c:913:9: error: expected expression before ‘}’ token
end
