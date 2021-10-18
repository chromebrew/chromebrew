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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_speechrecognition/3.8.1-1_x86_64/py3_speechrecognition-3.8.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'afeaccf883b59a06cb867d28304aa1ddf5d241471ea99bd2a0ac365b787a3684',
     armv7l: 'afeaccf883b59a06cb867d28304aa1ddf5d241471ea99bd2a0ac365b787a3684',
     x86_64: '02fb72edebb23f4faeeb6c6a0e26d4985bee4a878556186d76c2e7b922eeeb32'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
