require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.8.10-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '414f21d5f2e26d5887ff35bd347cd1f1c4e31152b06fa94297fd45e8a9184f81',
     armv7l: '414f21d5f2e26d5887ff35bd347cd1f1c4e31152b06fa94297fd45e8a9184f81',
       i686: 'c04e336885d07ba5aa980219c6257fbe0e53afccd6750ec2f296df05ed780cff',
     x86_64: '6b4d945b556086c4e02851aad2b931a7430eda1f534fdbbd70d9d27cfa52dd9e'
  })

  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
