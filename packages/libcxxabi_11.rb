require 'package'

class Libcxxabi_11 < Package
  description 'libc++ ABI, along with libc++, provides a standard conformant and high-performance implementation of the C++ Standard Library.'
  homepage 'https://libcxxabi.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/libcxxabi-11.1.0.src.tar.xz'
  source_sha256 '143193ed80f8fa4d85211d6704a90789fb36aa65b69fd0c382a9f05ec370ecab'


end
