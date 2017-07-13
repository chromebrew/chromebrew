require 'package'

class Lldb < Package
  description 'LLDB is a next generation, high-performance debugger.'
  homepage 'http://lldb.llvm.org/'
  version '3.6'
  binary_url ({
    i686: 'https://www.dropbox.com/s/bls4hv4z8m2ifsc/lldb-3.6-i386.tar.gz?dl=0',
    x86_64: 'https://www.dropbox.com/s/zi3rzdmz2awu8u8/lldb-3.6-64x.tar.gz?dl=0'
  })
  binary_sha256 ({
    i686: '7bdb9d0078aa0a6bd1d56df24e076a007a80274dbd0870b7d81a4a9767da49b2',
    x86_64: 'ac81a42662a1fde6b6a0dfb9e81be93deefc4ef78f80e67114dfc6fcaf65f4fa'
  })
end
