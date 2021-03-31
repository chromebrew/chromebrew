require 'package'

class Libcxx_11 < Package
  description 'libc++, along with libc++ ABI, provides a standard conformant and high-performance implementation of the C++ Standard Library.'
  homepage 'https://libcxx.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/libcxx-11.1.0.src.tar.xz'
  source_sha256 'bb233d250ed7eaa05c73eaf81ef0f9ee3fac9d8fc0c3d38a7a7383f82ed6f8e5'


end
