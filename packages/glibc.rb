require 'package'

class Glibc < Package
  version '2.17.90-baseline'
  binary_url ({
    armv7l: "https://dl.dropboxusercontent.com/s/aryy15mmewfegko/glibc-2.19-chromeos-armv7l.tar.xz",
    i686: "https://dl.dropboxusercontent.com/s/dic47f8eqxhpf89/glibc-2.17.90-baseline-chromeos-i686.tar.gz?token_hash=AAHx_77YtWLLnkjCJRaCJt7RsdKrfkT6lgKS9BZc4O-0Pg&dl=1",
    x86_64: "https://dl.dropboxusercontent.com/s/x3tu160i7pmn6tp/glibc-2.17-baseline-chromeos-x86_64.tar.gz?token_hash=AAG794JG65HjzHMcAyAysQUbEPMUci1bZJPREj3ztCtnBg&dl=1"
  })
  binary_sha1 ({
    armv7l: "db77567362689e644970ac6fe1fb4eb17b893e4d",
    i686: "3c3a0b86ed4591ec59daeb24d2dcda139574de1b",
    x86_64: "d818775f74d91692828f12321044cd95fc649cf0"
  })
end
