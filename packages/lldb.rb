require 'package'

class Lldb < Package
  description 'LLDB is a next generation, high-performance debugger.'
  homepage 'http://lldb.llvm.org/'
  version '3.6'
  binary_url ({
    i686: "https://www.dropbox.com/s/bls4hv4z8m2ifsc/lldb-3.6-i386.tar.gz?dl=0",
    x86_64: "https://www.dropbox.com/s/zi3rzdmz2awu8u8/lldb-3.6-64x.tar.gz?dl=0"
  })
  binary_sha1 ({
    i686: "de6ca73c1bcc0d72db81d14cd4e31b8f479e12e8",
    x86_64: "6265cacf22b191e22a439019b4a2eb0ef7df3813"
  })
end
