require 'buildsystems/cmake'

class Freecad < CMake
  description 'A free and opensource multiplatform 3D parametric modeler.'
  homepage 'https://www.freecad.org/'
  version '1.1.1'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/FreeCAD/FreeCAD.git'
  git_hashtag version

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'boost'
  depends_on 'coin'
  depends_on 'eigen'
  depends_on 'hdf5'
  depends_on 'libfmt'
  depends_on 'libmedfile'
  depends_on 'opencascade'
  depends_on 'pivy'
  depends_on 'py3_pybind11'
  depends_on 'qt5_base'
  depends_on 'qt5_svg'
  depends_on 'qt5_tools'
  depends_on 'swig'
  depends_on 'vtk'
  depends_on 'xercesc'
  depends_on 'yaml_cpp'

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.cache/FreeCAD")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/FreeCAD")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/.local/share/FreeCAD")
  end

  cmake_options "-Dpybind11_DIR=#{CREW_PREFIX}/lib/python#{CREW_PY_VER.delete_prefix('py')}/site-packages/pybind11/share/cmake/pybind11"
end
