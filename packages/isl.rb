require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.18-1'
  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/isl-0.18-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew-cross/isl-0.18-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew-cross/isl-0.18-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew-cross/isl-0.18-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34ab13258b490e96932dc8cb79fd3f7f6ec1e724aba829011cc5f2b16644c28e',
     armv7l: '34ab13258b490e96932dc8cb79fd3f7f6ec1e724aba829011cc5f2b16644c28e',
       i686: '513b04781a6759ffff0481151090711b19a29bc636a9839e9b571b1cb4276ac7',
     x86_64: 'dbab5361321ea49a310e8d6507464438f227dff149223d68a797d4479ae1c173',
  })
end
