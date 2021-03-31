require 'package'

class Clang_11 < Package
  description 'Clang is a C/C++/Objective-C compiler from LLVM that provides fast compiles, in-depth warnings and other debugging tools.'
  homepage 'https://clang.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/clang-11.1.0.src.tar.xz'
  source_sha256 '0a8288f065d1f57cb6d96da4d2965cbea32edc572aa972e466e954d17148558b'


end
