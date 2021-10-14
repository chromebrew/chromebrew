require 'package'

class Py3_speechrecognition < Package
  description 'SpeechRecognition is a library for performing speech recognition, with support for several engines and APIs, online and offline.'
  homepage 'https://github.com/Uberi/speech_recognition/'
  @_ver = '3.8.1'
  version @_ver + '-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/Uberi/speech_recognition.git'
  git_hashtag @_ver

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
