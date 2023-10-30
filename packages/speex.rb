require 'buildsystems/autotools'

class Speex < Autotools
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://gitlab.xiph.org/xiph/speex.git'
  git_hashtag "Speex-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2.1_armv7l/speex-1.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2.1_armv7l/speex-1.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2.1_i686/speex-1.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/speex/1.2.1_x86_64/speex-1.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9b951f2a67e662c4c38f53298af1ade1dce898c96ef9ef47e3f59adbb20900ce',
     armv7l: '9b951f2a67e662c4c38f53298af1ade1dce898c96ef9ef47e3f59adbb20900ce',
       i686: 'ad5627f756d4a1b07e229d1823f70d2e36ecbcdb56f083c990f06dfdd2662f26',
     x86_64: '6c0d8ff5ab8e2ac17cac3039f2f6bcd75790e1815478d5421beaa13c1cd2f483'
  })

  depends_on 'glibc' # R

  configure_options '--disable-dependency-tracking \
      --disable-maintainer-mode \
      --disable-examples'
end
