require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version '6.0.0-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4098f42613622e371ed69aec9753d3fb7bb29513ad6db37040cce27bbc333cf2',
     armv7l: '4098f42613622e371ed69aec9753d3fb7bb29513ad6db37040cce27bbc333cf2',
       i686: '70e6dd1d5c8c94239a4e73fce69d83a7acb3ac2589756130e18525d290049c43',
     x86_64: '9c68f25c300abd449516801b9447867bac1209782ebf1e76d203d9e870fca8f3'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
