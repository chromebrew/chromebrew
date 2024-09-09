require 'buildsystems/pip'

class Py3_et_xmlfile < Pip
  description 'Et-xmlfile is an implementation of lxml\'s xmlfile module for the standard library\'s ElementTree.'
  homepage 'https://foss.heptapod.net/openpyxl/et_xmlfile'
  version '1.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '089b69434bd2f42b9c5b864c35258a43c5e2c03d618ac2bf8705046221237f16',
     armv7l: '089b69434bd2f42b9c5b864c35258a43c5e2c03d618ac2bf8705046221237f16',
       i686: '51b1912ce002fdb87c3e8fca72ad0d9f2c972e14281691d24339252a55870854',
     x86_64: 'f32979c3fd3adcceaf949350deaa8df797b028f9d6f8a3e746de81da6beb4dea'
  })

  depends_on 'python3' => :build

  no_source_build
end
