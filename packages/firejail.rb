require 'buildsystems/autotools'

class Firejail < Autotools
  description 'Firejail is a SUID program that reduces the risk of security breaches by restricting the running environment of untrusted applications
  by using Linux namespaces and seccomp-bpf.'
  homepage 'https://firejail.wordpress.com'
  version '0.9.82'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/netblue30/firejail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e93ed559b994ca9d0655fccce4fb43ea8160042697dc5c7551ee119047b4559b',
     armv7l: 'e93ed559b994ca9d0655fccce4fb43ea8160042697dc5c7551ee119047b4559b',
     x86_64: 'a16e003865d8b0ec3aa0ad0a877f0fe560669a743555b2d76fe0bdc45b7336e5'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  # Unable to build i686: src/lib/syscall.c:913:9: error: expected expression before ‘}’ token
end
