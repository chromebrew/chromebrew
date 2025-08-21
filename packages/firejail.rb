require 'buildsystems/autotools'

class Firejail < Autotools
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.76'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/netblue30/firejail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bff33bf236831eb1ca5c0ba2064733cca9c422811ebbea36f082ebcaca0df080',
     armv7l: 'bff33bf236831eb1ca5c0ba2064733cca9c422811ebbea36f082ebcaca0df080',
       i686: 'f5873641f744bc3177d4df5cad0bf34d86ad96c74e47eb3792506f216880b915',
     x86_64: '9e100ef06b2fdda9994c6c134b2dd3a2b21e0ea5699bb278ee986903d8db6f35'
  })

  depends_on 'glibc' # R
end
