require 'buildsystems/autotools'

class Firejail < Autotools
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.78'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/netblue30/firejail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31b144e9c5bd0a2595c8f00743fbc52304d428d10f9025f1653d7584d92ddb69',
     armv7l: '31b144e9c5bd0a2595c8f00743fbc52304d428d10f9025f1653d7584d92ddb69',
       i686: '4cc0204abcc35d160c87aa5e6184ad2d9981ead98003ff0cb1e0027e80ccc32f',
     x86_64: '3894ac400e6f178405b03de5af04876ef73986fbe36b68e3bb0996e98ece6e43'
  })

  depends_on 'glibc' # R
end
