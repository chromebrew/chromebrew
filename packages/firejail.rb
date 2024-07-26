require 'buildsystems/autotools'

class Firejail < Autotools
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.72-60ea220'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/netblue30/firejail.git'
  git_hashtag '60ea22080a36c66c3e90b75e016ad6324575c7a0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a34d46a5fb832516d072e064e3f71abd3f87a299960b465880b512450dc555e4',
     armv7l: 'a34d46a5fb832516d072e064e3f71abd3f87a299960b465880b512450dc555e4',
       i686: '0d7145aa047152da398cd50d1495a74cb8d93b4ec5db380ea771446af9aa07f6',
     x86_64: 'a64b8e303201574631b07dd00d7813688ee2ade71b763d45eb99c496257fa351'
  })
end
