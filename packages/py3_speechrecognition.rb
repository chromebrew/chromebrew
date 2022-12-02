require 'package'

class Py3_speechrecognition < Package
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  @_ver = '3.8.1'
  version "#{@_ver}-py3.11"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Uberi/speech_recognition.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-py3.11_armv7l/py3_speechrecognition-3.8.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-py3.11_armv7l/py3_speechrecognition-3.8.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-py3.11_i686/py3_speechrecognition-3.8.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-py3.11_x86_64/py3_speechrecognition-3.8.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f909efc4936a471be157a364adc6cbb71438eee71979c78470f6657a990eb868',
     armv7l: 'f909efc4936a471be157a364adc6cbb71438eee71979c78470f6657a990eb868',
       i686: 'e6c4a54bc57ac29acd78241f0865a393ea94987eefde5eb3f9692883e8cb0abd',
     x86_64: '209d4474b031f48507075d5f843943f6c30f675e69f5735659fc8ee98a6ccf05'
  })

  depends_on 'python3' => :build
  depends_on 'glibc' # R

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
