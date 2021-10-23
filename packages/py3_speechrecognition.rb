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
    aarch64: 'c5ce5dffc5505a1ab1e1f04499f240e85f33fb36bd7ea917cd5d7f1a5de6bf77',
     armv7l: 'c5ce5dffc5505a1ab1e1f04499f240e85f33fb36bd7ea917cd5d7f1a5de6bf77',
       i686: '875b1e7ec7e45f47dcfb767d21f75d2f23ad38fbf8f0d81bf8789f7053bf083f',
     x86_64: '095fb255a9245b66a4d1e174ea285362abd575b7d9f8227fef08f17fcef81b59'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
