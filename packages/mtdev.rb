require 'buildsystems/autotools'

class Mtdev < Autotools
  description 'The mtdev is a stand-alone library which transforms all variants of kernel MT events to the slotted type B protocol.'
  homepage 'https://bitmath.org/code/mtdev/'
  version '1.1.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://bitmath.org/git/mtdev.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3aa454e83b4dd1fe256fe4fbdd4304d94c4cac24beafa479c1069ee589c6a5e',
     armv7l: 'e3aa454e83b4dd1fe256fe4fbdd4304d94c4cac24beafa479c1069ee589c6a5e',
       i686: 'f5fc42cb0f32c91392a5850cd43dfddb3bbdff969173cbff6f2eca0026467c9b',
     x86_64: '49dbf2523821a3c5a2fc582adb4b2b3e36726b9f73b5cf7bf9920e846f5ddf31'
  })

  # Otherwise the clone fails like so:
  # fatal: dumb http transport does not support shallow capabilities
  # It seems like git should just retry with a non-shallow clone in this scenario, but that doesn't seem to be the case.
  git_clone_deep
end
