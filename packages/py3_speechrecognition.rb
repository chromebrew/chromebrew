require 'package'

class Py3_speechrecognition < Package
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  @_ver = '3.8.1'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Uberi/speech_recognition.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1_armv7l/py3_speechrecognition-3.8.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1_armv7l/py3_speechrecognition-3.8.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1_x86_64/py3_speechrecognition-3.8.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6a7c922b92517dfc88374777aa7a4a46b46454b06b97dc4f7e9f7c5c276117b2',
     armv7l: '6a7c922b92517dfc88374777aa7a4a46b46454b06b97dc4f7e9f7c5c276117b2',
     x86_64: '616ac521e9abc6844240623932a93a42421bc0e716a5733e8d11546bc4e9dbfd'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
