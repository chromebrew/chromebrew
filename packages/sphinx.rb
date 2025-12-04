require 'buildsystems/pip'

class Sphinx < Pip
  description 'Sphinx is a tool that makes it easy to create intelligent and beautiful documentation.'
  homepage 'https://www.sphinx-doc.org/'
  version "9.0.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6764f77ebf38bfd24b6b7f04a706f355fd9fa0152bd98b5a52cad2f4e83ce069',
     armv7l: '6764f77ebf38bfd24b6b7f04a706f355fd9fa0152bd98b5a52cad2f4e83ce069',
       i686: '4ca18d7635c92e2ba99b3b79cf633d6162bc67b305d7e06da6f7d66dbde495a9',
     x86_64: '30645c21680e73e8f34d2595cfaeb68ce86b7e28e6451ec2ffe3750dbede5578'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_sphinxcontrib_devhelp'
  depends_on 'py3_sphinxcontrib_applehelp'
  depends_on 'py3_sphinxcontrib_jsmath'
  depends_on 'py3_sphinxcontrib_serializinghtml'
  depends_on 'py3_sphinxcontrib_qthelp'
  depends_on 'py3_sphinxcontrib_htmlhelp'
  depends_on 'py3_docutils'
  depends_on 'py3_imagesize'
  depends_on 'py3_requests'
  depends_on 'py3_babel'
  depends_on 'py3_alabaster'
  depends_on 'py3_pygments'
  depends_on 'py3_packaging'
  depends_on 'py3_snowballstemmer'
  depends_on 'python3' => :build

  no_source_build
end
