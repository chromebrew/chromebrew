require 'buildsystems/cmake'

class Faad2 < CMake
  description 'Freeware Advanced Audio (AAC) Decoder'
  homepage 'https://sourceforge.net/projects/faac/'
  version '2.11.1'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/knik0/faad2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7835b6df7e546977b55a315d31068fc339b0b48138b637ed42286c885cc2f239',
     armv7l: '7835b6df7e546977b55a315d31068fc339b0b48138b637ed42286c885cc2f239',
       i686: '7eab71e821affb50a103a634a3451596eb9c8f989fb39a71b2f7980e835216ca',
     x86_64: '322d138866130e28d08ffbf96656aed6e8a01a2774bee12919f608abcbd240fb'
  })

  depends_on 'glibc'
end
