require 'package'

class Py3_speechrecognition < Package
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  @_ver = '3.8.1'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Uberi/speech_recognition.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-1_armv7l/py3_speechrecognition-3.8.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-1_armv7l/py3_speechrecognition-3.8.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-1_i686/py3_speechrecognition-3.8.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-1_x86_64/py3_speechrecognition-3.8.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '899cf34ae1966bb640b809a0ded4159fc0e277fb9922a910d765489f847f68f7',
     armv7l: '899cf34ae1966bb640b809a0ded4159fc0e277fb9922a910d765489f847f68f7',
       i686: '15116653e27ab1394c183fcbf8162f370f54675f5186f5e19f11b0c4343c3e51',
     x86_64: '7ed62fee42ed227da8cfed6f2f6e528cfced98a985f872d513905d7a3ac73dbd'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
