require 'buildsystems/python'

class Py3_babel < Python
  description 'Babel is an integrated collection of utilities that assist in internationalizing and localizing Python applications.'
  homepage 'https://babel.pocoo.org/'
  @_ver = '2.13.0'
  version "#{@_ver}-py3.12"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-babel/babel.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.13.0-py3.12_armv7l/py3_babel-2.13.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.13.0-py3.12_armv7l/py3_babel-2.13.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.13.0-py3.12_i686/py3_babel-2.13.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_babel/2.13.0-py3.12_x86_64/py3_babel-2.13.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '104eec74ce764321b0c1473feacfa7a50450030d0d02e58ca8e276ab6c4e7e9d',
     armv7l: '104eec74ce764321b0c1473feacfa7a50450030d0d02e58ca8e276ab6c4e7e9d',
       i686: '361db2fdc8629ce1021aa173fbc77e0365b064bef530ef732fd45770ad34ce6f',
     x86_64: '3446c44e604c229916c2118e47a7054ec93868f411e15f7cd83eb5cbcf4c575f'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build
end
